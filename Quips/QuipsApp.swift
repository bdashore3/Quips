//
//  QuipsApp.swift
//  Quips
//
//  Created by Brian Dashore on 6/16/22.
//

import SwiftUI

@main
struct QuipsApp: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared

        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
