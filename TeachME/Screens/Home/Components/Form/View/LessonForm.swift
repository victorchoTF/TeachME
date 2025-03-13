//
//  LessonForm.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import SwiftUI

struct LessonForm: View {
    @ObservedObject var viewModel: LessonFormViewModel
    let theme: Theme
    let subtitleFieldMinHeight: CGFloat = 5
    
    var body: some View {
        NavigationView {
            Form {
                editFields
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    cancelButton
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    doneButton
                }
            }
            .navigationTitle(viewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private extension LessonForm {
    var editFields: some View {
        VStack(spacing: theme.spacings.large) {
            lessonDetailFields
            
            dateFields
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    
    var lessonDetailFields: some View {
        Section {
            lessonPicker
            
            subtitleField
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
    
    var subtitleField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $viewModel.subtitle)
                .frame(minHeight: subtitleFieldMinHeight)
                .styledTextField(theme: theme, padding: theme.spacings.extraSmall)
            if viewModel.shouldShowSubtitlePlaceholder {
                Text(viewModel.lessonSubtitlePlaceholder)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(theme.spacings.medium)
            }
        }
    }
    
    var lessonPicker: some View {
        Picker(viewModel.pickerLabel, selection: $viewModel.lessonType) {
            ForEach(viewModel.lessonTypes, id: \.self) { type in
                Text(type)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
    
    var dateFields: some View {
        Section {
            startDateStack
            
            endDateStack
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
        .foregroundStyle(theme.colors.text)
    }
    
    var startDateStack: some View {
        VStack(alignment: .leading, spacing: theme.spacings.medium) {
            DatePicker(
                viewModel.startDateLabel,
                selection: $viewModel.startDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            Text(viewModel.startDateHint)
                .font(theme.fonts.footnote)
                .opacity(0.5)
        }
    }
    
    var endDateStack: some View {
        VStack(alignment: .leading, spacing: theme.spacings.medium) {
            DatePicker(
                viewModel.endDateLabel,
                selection: $viewModel.endDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            
            Text(viewModel.endDateHint)
                .font(theme.fonts.footnote)
                .opacity(0.5)
        }
    }
    
    var cancelButton: some View {
        ActionButton(
            buttonContent: .text(
                Text(viewModel.cancelButtonText)
            )
        ) {
            viewModel.onCancel()
        }
        .foregroundStyle(theme.colors.accent)
    }
    
    var doneButton: some View {
        ActionButton(
            buttonContent: .text(
                Text(viewModel.doneButtonText)
            )
        ) {
//            Task {
//                try await viewModel.onSubmit()
//            }
            print("Opened")
        }
        .foregroundStyle(theme.colors.accent)
    }
}
