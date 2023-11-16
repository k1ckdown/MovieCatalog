//
//  ReviewDialog.swift
//  Movies
//
//  Created by Ivan Semenov on 12.11.2023.
//

import SwiftUI

struct ReviewDialog: View {
    
    let viewModel: ReviewDialogViewModel
    let eventHandler: (ReviewDialogViewEvent) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedKey.Review.leave)
                .font(.title2.bold())
            
            Spacer()
            
            VStack(alignment: .leading, spacing: Constants.TextEditor.spacing) {
                HStack(spacing: Constants.StarRating.spacing) {
                    ForEach(1...Constants.StarRating.max, id: \.self) { value in
                        let isSelected = value <= viewModel.rating
                        
                        Button {
                            withAnimation(.interpolatingSpring) {
                                eventHandler(.ratingChanged(value))
                            }
                        } label: {
                            Image(
                                systemName: isSelected
                                ? Constants.StarRating.starFill
                                : Constants.StarRating.star
                            )
                            .foregroundStyle(isSelected ? .yellow : .appGray)
                        }
                    }
                    .imageScale(.large)
                }
                
                TextEditorWithPlaceholder(
                    text: reviewText,
                    placeholder: LocalizedKey.Review.write,
                    horizontalInset: Constants.TextEditor.horizontalInsets
                )
                .tint(.appAccent)
                .frame(height: Constants.TextEditor.height)
                .clipShape(.rect(cornerRadius: Constants.TextEditor.cornerRadius))
                .scrollContentBackground(.hidden)
                .overlay {
                    RoundedRectangle(cornerRadius: Constants.TextEditor.cornerRadius)
                        .stroke(Color.appGray)
                }
                
                HStack {
                    Button {
                        eventHandler(.isAnonymous(viewModel.isAnonymous == false))
                    } label: {
                        Image(systemName: Constants.Content.checkmarkName)
                            .foregroundStyle(.white, viewModel.isAnonymous ? .appAccent : .white)
                            .imageScale(.large)
                            .bold()
                    }
                    
                    Text(LocalizedKey.Review.anonymous)
                        .font(.callout.weight(.medium))
                }
            }
            .padding(.bottom)
            
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
                    .tint(.appAccent)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
            } else {
                VStack {
                    Button(LocalizedKey.Profile.save) {
                        withAnimation {
                            eventHandler(.saveTapped)
                        }
                    }
                    .baseButtonStyle()
                    .disabled(viewModel.text.isEmpty)
                    
                    Button(LocalizedKey.Profile.cancel) {
                        withAnimation {
                            eventHandler(.cancelTapped)
                        }
                    }
                    .baseButtonStyle(isProminent: false)
                }
            }
        }
        .padding()
        .backgroundColor()
        .frame(height: Constants.Content.height)
        .clipShape(.rect(cornerRadius: Constants.Content.cornerRadius))
    }
    
    private var reviewText: Binding<String> {
        Binding(
            get: { viewModel.text },
            set: { eventHandler(.reviewTextChanged($0)) }
        )
    }
    
    private enum Constants {
        enum StarRating {
            static let max = 10
            static let star = "star"
            static let starFill = "star.fill"
            static let spacing: CGFloat = 5
        }
        
        enum TextEditor {
            static let spacing: CGFloat = 12
            static let height: CGFloat = 110
            static let cornerRadius: CGFloat = 5
            static let horizontalInsets: CGFloat = 7
        }
        
        enum Content {
            static let height: CGFloat = 380
            static let cornerRadius: CGFloat = 10
            static let checkmarkName = "checkmark.square.fill"
        }
    }
}
