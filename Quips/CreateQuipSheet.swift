//
//  CreateQuipSheet.swift
//  Quips
//
//  Created by Brian Dashore on 6/16/22.
//

import SwiftUI

struct CreateQuipSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    let backgroundContext = PersistenceController.shared.backgroundContext

    @State var quip: Quip? = nil
    
    @State private var postText = ""
    @State private var authorText = ""
    @State private var wordCount = 0

    var body: some View {
        NavView {
            VStack {
                VStack {
                    if #available(iOS 16, *) {
                        TextField("Start typing", text: $postText, axis: .vertical)
                            .lineLimit(8...)
                            .textInputAutocapitalization(.sentences)
                    } else {
                        TextEditor(text: $postText)
                            .frame(maxHeight: 300)
                            .textInputAutocapitalization(.sentences)
                    }

                    Divider()
                        .frame(height: 2)
                        .overlay(.secondary)

                    HStack {
                        Text("Author:")
                        TextField("Who said this?", text: $authorText)
                            .lineLimit(1)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Characters: \(postText.count)")
                        Spacer()
                        Button {
                            if postText == "" || authorText == "" {
                                return
                            }

                            if let unwrappedQuip = quip {
                                // Update an existing bookmark
                                unwrappedQuip.text = postText
                                unwrappedQuip.author = authorText
                            } else {
                                // Upsert an existing quip
                                let quipRequest = Quip.fetchRequest()
                                quipRequest.predicate = NSPredicate(format: "text == %@ AND author == %@", postText, authorText)
                                quipRequest.fetchLimit = 1

                                if let existingQuip = try? backgroundContext.fetch(quipRequest).first {
                                    PersistenceController.shared.delete(existingQuip, context: backgroundContext)
                                }

                                // Set a new quip
                                let quip = Quip(context: backgroundContext)
                                quip.text = postText
                                quip.author = authorText
                            }

                            PersistenceController.shared.save(backgroundContext)

                            dismiss()

                            quip = nil
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding(7)
                        }
                        .background(.primary)
                        .disabledAppearance(postText == "" || authorText == "")
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal)
                }
                .padding()
                .border(.primary, width: 1)
                .onAppear {
                    postText = quip?.text ?? ""
                    authorText = quip?.author ?? ""
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Create quip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct CreateQuipSheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateQuipSheet()
    }
}
