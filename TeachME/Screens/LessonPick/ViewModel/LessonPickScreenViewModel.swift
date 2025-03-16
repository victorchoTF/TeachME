//
//  LessonPickScreenViewModel.swift
//  TeachME
//
//  Created by TumbaDev on 30.01.25.
//

import Foundation

@MainActor final class LessonPickScreenViewModel: ObservableObject {
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
                    pickedLesson.teacherId
                )
            )
            
            otherLessons = try await repository.getLessonsByTeacherId(
                pickedLesson.teacherId
            ).map {
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
    
    func pickLessonButtonAction() {
        guard let router = router else {
            return
        }
        
        switch router.user.role {
        case .Teacher: teacherAction()
        case .Student: studentAction()
        }
    }
}

private extension LessonPickScreenViewModel {
    func teacherAction() {
        self.lessonFormViewModel = LessonFormViewModel(
            lesson: self.pickedLesson,
            formType: FormType.edit,
            repository: lessonTypeRepository,
            dateFormatter: DateFormatter(),
            onCancel: { [weak self] in
                self?.lessonFormViewModel = nil
            }
        ) { [weak self] lesson in
            self?.pickedLesson = lesson
            self?.lessonFormViewModel = nil
        }
    }
    
    func studentAction() {
        print("Saving: \(self.pickedLesson)")
    }
}

extension LessonPickScreenViewModel: Equatable {
    static func == (lhs: LessonPickScreenViewModel, rhs: LessonPickScreenViewModel) -> Bool {
        lhs.pickedLesson.id == rhs.pickedLesson.id
    }
}
