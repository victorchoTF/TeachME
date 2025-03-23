//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation

final class LessonPickScreenViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var pickedLesson: LessonItem
    @Published var teacher: UserItem?
    @Published var lessonFormViewModel: LessonFormViewModel?
    @Published var otherLessons: [LessonItem] = []
    
    private let repository: LessonRepository
    private let userRepository: UserRepository
    private let lessonTypeRepository: LessonTypeRepository
    
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    private weak var router: HomeRouter?
    
    init(
        pickedLesson: LessonItem,
        router: HomeRouter,
        repository: LessonRepository,
        userRepostirory: UserRepository,
        lessonTypeRepository: LessonTypeRepository,
        mapper: LessonMapper,
        userMapper: UserMapper
    ) {
        self.pickedLesson = pickedLesson
        self.router = router
        self.repository = repository
        self.userRepository = userRepostirory
        self.lessonTypeRepository = lessonTypeRepository
        self.mapper = mapper
        self.userMapper = userMapper
    }
    
    func onLessonTap(lesson: LessonItem, theme: Theme) {
        guard let router = router else {
            return
        }
        
        router.push(
            .lesson(
                LessonPickScreenViewModel(
                    pickedLesson: lesson,
                    router: router, 
                    repository: repository,
                    userRepostirory: userRepository,
                    lessonTypeRepository: lessonTypeRepository,
                    mapper: mapper,
                    userMapper: userMapper
                ),
                theme
            )
        )
    }
    
    func loadData() async{
        do {
            teacher = try await userMapper.modelToItem(
                userRepository.getById(
                    pickedLesson.teacher.id
                )
            )
            
            otherLessons = try await repository.getLessonsByTeacherId(
                pickedLesson.teacher.id
            )
            .filter {
                $0.student == nil
            }
            .map {
                mapper.modelToItem($0)
            }
            .filter {
                $0.id != pickedLesson.id
            }
        } catch {
            print("An error occured")
        }
    }
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        switch router?.user.role {
        case .Teacher: "Edit"
        default: "Save"
        }
    }
    
    var alertMessage: String {
        "Lesson with \(pickedLesson.teacher.name) saved successfully!"
    }
    
    func pickLessonButtonAction() {
        guard let user = router?.user else {
            return
        }
        
        switch user.role {
        case .Teacher: teacherAction()
        case .Student: studentAction()
        }
    }
    
    func exit() {
        router?.popToRoot()
    }
}

private extension LessonPickScreenViewModel {
    func teacherAction() {
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: self.pickedLesson,
            teacher: self.pickedLesson.teacher,
            formType: FormType.edit,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            self?.updateLesson(lesson: lesson)
            
            self?.pickedLesson = lesson
            self?.lessonFormViewModel = nil
        }
    }
    
    func studentAction() {
        takeLesson()
        showAlert = true
    }
    
    func takeLesson() {
        Task {
            guard let lessonBody = try await lessonBodyModelByLessonItem(
                lesson: pickedLesson
            ) else {
                return
            }
            
            guard let lessonBodyWithStudent = try await addStudentToLessonBody(lessonBody) else {
                return
            }
            
            try await self.repository.takeLesson(lessonBodyWithStudent, id: pickedLesson.id)
        }
    }
    
    // FIXME: Certain cases couse Internal Server Error
    func updateLesson(lesson: LessonItem) {
        Task {
            guard let lessonBody = try await lessonBodyModelByLessonItem(lesson: lesson) else {
                return
            }
            
            try await self.repository.update(lessonBody, id: lesson.id)
        }
    }
    
    func lessonBodyModelByLessonItem(lesson: LessonItem) async throws -> LessonBodyModel? {
        guard let user = self.router?.user else {
            return nil
        }
        
        guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
            $0.name == lesson.lessonType
        }) else {
            return nil
        }
        
        let userLessonBody = self.userMapper.itemToBodyLessonModel(user)
        
        let lessonModel = try self.mapper.itemToBodyModel(
            lesson,
            lessonTypeModel: lessonTypeModel,
            teacherItem: userLessonBody
        )
        
        return lessonModel
    }
    
    func addStudentToLessonBody(_ body: LessonBodyModel) async throws -> LessonBodyModel? {
        guard let user = router?.user else {
            return nil
        }
        
        return LessonBodyModel(
            lessonType: body.lessonType,
            subtitle: body.subtitle,
            startDate: body.startDate,
            endDate: body.endDate,
            teacher: body.teacher,
            student: userMapper.itemToBodyLessonModel(user)
        )
    }
}

extension LessonPickScreenViewModel: Equatable {
    static func == (lhs: LessonPickScreenViewModel, rhs: LessonPickScreenViewModel) -> Bool {
        lhs.pickedLesson.id == rhs.pickedLesson.id
    }
}
