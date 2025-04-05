//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation

@MainActor final class LessonPickScreenViewModel: ObservableObject {
    @Published var alertItem: AlertItem? = nil
    @Published var pickedLesson: LessonItem
    @Published var teacher: UserItem?
    @Published var lessonFormViewModel: LessonFormViewModel?
    @Published var otherLessons: [LessonItem] = []
    
    @Published var user: UserItem
    private let repository: LessonRepository
    private let userRepository: UserRepository
    private let lessonTypeRepository: LessonTypeRepository
    
    private let mapper: LessonMapper
    private let userMapper: UserMapper
    
    private weak var router: HomeRouter?
    
    init(
        pickedLesson: LessonItem,
        user: UserItem,
        router: HomeRouter,
        repository: LessonRepository,
        userRepostirory: UserRepository,
        lessonTypeRepository: LessonTypeRepository,
        mapper: LessonMapper,
        userMapper: UserMapper
    ) {
        self.pickedLesson = pickedLesson
        self.user = user
        self.router = router
        self.repository = repository
        self.userRepository = userRepostirory
        self.lessonTypeRepository = lessonTypeRepository
        self.mapper = mapper
        self.userMapper = userMapper
    }
    
    func onLessonTap(lesson: LessonItem, theme: Theme) {
        guard let router = router else {
            alertItem = AlertItem(alertType: .lessonLoading)
            return
        }
        
        router.push(
            .lesson(
                LessonPickScreenViewModel(
                    pickedLesson: lesson,
                    user: user,
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
    
    func loadData() async {
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
            alertItem = AlertItem(alertType: .lessonLoading)
        }
    }
    
    var moreAboutTitle: String {
        "More about the teacher"
    }
    
    var otherLessonsTitle: String {
        "Other lessons"
    }
    
    var pickLessonButtonText: String {
        switch user.role {
        case .teacher: "Edit"
        default: "Save"
        }
    }
    
    func pickLessonButtonAction() {
        switch user.role {
        case .teacher: teacherAction()
        case .student: studentAction()
        }
    }
    
    func exit() {
        router?.popToRoot()
    }
}

private extension LessonPickScreenViewModel {
    func teacherAction() {
        self.lessonFormViewModel = LessonFormViewModel(
            teacher: self.pickedLesson.teacher,
            formType: FormType.edit,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            lessonFormType: .edit(pickedLesson) { [weak self] lesson in
                try await self?.updateLesson(lesson: lesson)
                
                self?.pickedLesson = lesson
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] in
            self?.lessonFormViewModel = nil
        }
    }
    
    func studentAction() {
        takeLesson()
        alertItem = AlertItem(
            alertType: .saved(pickedLesson.teacher.name),
            primaryAction: .defaultCancelation(exit)
        )
    }
    
    func takeLesson() {
        Task {
            guard let lessonBody = try await lessonBodyModelByLessonItem(
                lesson: pickedLesson
            ) else {
                return
            }

            try await self.repository.takeLesson(
                try await addStudentToLessonBody(lessonBody),
                id: pickedLesson.id
            )
        }
    }
    
    func updateLesson(lesson: LessonItem) async throws {
        guard let lessonBody = try await lessonBodyModelByLessonItem(lesson: lesson) else {
            return
        }
        
        try await self.repository.update(lessonBody, id: lesson.id)
    }
    
    func lessonBodyModelByLessonItem(lesson: LessonItem) async throws -> LessonBodyModel? {
        guard let lessonTypeModel = try await self.lessonTypeRepository.getAll().first(where: {
            $0.name == lesson.lessonType
        }) else {
            return nil
        }
        
        let userLessonBody = self.userMapper.itemToBodyLessonModel(user)
        
        let lessonModel = try self.mapper.itemToBodyModel(
            mapper.itemToItemBody(lesson),
            lessonTypeModel: lessonTypeModel,
            teacherItem: userLessonBody
        )
        
        return lessonModel
    }
    
    func addStudentToLessonBody(_ body: LessonBodyModel) async throws -> LessonBodyModel {
        LessonBodyModel(
            lessonType: body.lessonType,
            subtitle: body.subtitle,
            startDate: body.startDate,
            endDate: body.endDate,
            teacher: body.teacher,
            student: userMapper.itemToBodyLessonModel(user)
        )
    }
}

extension LessonPickScreenViewModel: Identifiable {}
