//
//  ContentView.swift
//  Quips
//
//  Created by Brian Dashore on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    @FetchRequest(
        entity: Quip.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Quip.date, ascending: true)
        ]
    ) var quips: FetchedResults<Quip>

    @State private var showQuipSheet = false

    var body: some View {
        NavView {
            ZStack {
                if quips.isEmpty {
                    VStack {
                        Text("It looks like you have no quips.")
                        Text("Use the pencil button to create your first one.")
                    }
                    .padding(.bottom, 40)
                    .zIndex(0)
                } else {
                    ScrollView {
                        VStack(spacing: 15) {
                            ForEach(quips, id: \.self) { currentQuip in
                                CardView(quip: currentQuip)
                            }
                        }
                        .padding()
                    }
                    .zIndex(0)
                }

                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()

                        Button {
                            showQuipSheet.toggle()
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title.weight(.heavy))
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .padding(12)
                        }
                        .background(.primary)
                        .clipShape(Capsule())
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                }
                .zIndex(1)
            }
            .sheet(isPresented: $showQuipSheet) {
                CreateQuipSheet()
            }
            .navigationTitle("Your quips")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
