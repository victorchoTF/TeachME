//
//  EditLessonForm.swift
//  TeachME
//
//  Created by TumbaDev on 13.02.25.
//

import SwiftUI

struct EditLessonForm: View {
    @ObservedObject var viewModel: EditLessonFormViewModel
    let theme: Theme
    
    var body: some View {
        Form {
            FormTitle(title: viewModel.formTitle, theme: theme)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            
            editFields
            
            SubmitButton(text: viewModel.buttonText, theme: theme) {
                viewModel.onSubmit()
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .font(theme.fonts.body)
        }
    }
}

private extension EditLessonForm {
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
        Section(header: Text(viewModel.lessonDetailSectionTitle).font(theme.fonts.headline)) {
            lessonPicker
            
            TextField(viewModel.lessonSubtitlePlaceholder, text: $viewModel.subtitle)
                .styledTextField(theme: theme)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
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
        Section(header: Text(viewModel.scheduleSectionTitle).font(theme.fonts.headline)) {
            DatePicker(
                viewModel.startDateLabel,
                selection: $viewModel.startDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            
            DatePicker(
                viewModel.endDateLabel,
                selection: $viewModel.endDate,
                displayedComponents: [.date, .hourAndMinute]
            )
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .font(theme.fonts.body)
    }
}
