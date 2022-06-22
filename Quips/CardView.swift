//
//  CardView.swift
//  Quips
//
//  Created by Brian Dashore on 6/16/22.
//

import SwiftUI

struct CardView: View {
    @Environment(\.colorScheme) var colorScheme

    let backgroundContext = PersistenceController.shared.backgroundContext

    // Make this a struct from CoreData
    @ObservedObject var quip: Quip

    @State private var showQuipSheet = false
    @State private var showQuipDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(quip.text ?? "This quote went missing!")
                .padding(.horizontal)
                .padding(.bottom, 5)
                .font(.title2)

            HStack {
                Text(quip.author ?? "No author!")
                    .fontWeight(.light)

                Spacer()

                Text(DateFormatter.quipDateFormatter.string(from: quip.date ?? Date()))
                    .fontWeight(.light)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)

            HStack(spacing: 15) {
                Spacer()
                Button {
                    showQuipDeleteAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.secondary)
                }
                .alert(isPresented: $showQuipDeleteAlert) {
                    return Alert(
                        title: Text("Are you sure?"),
                        message: Text("This quip will be lost forever! \n(a long time)"),
                        primaryButton: .destructive(Text("Yes")) {
                            PersistenceController.shared.delete(quip, context: backgroundContext)
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Button {
                    showQuipSheet.toggle()
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.secondary)
                }
                .sheet(isPresented: $showQuipSheet) {
                    CreateQuipSheet(quip: quip)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .border(colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.7), width: 3, cornerRadius: 10)
    }
}
