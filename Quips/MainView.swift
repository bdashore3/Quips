//
//  MainView.swift
//  Quips
//
//  Created by Brian Dashore on 6/20/22.
//

import SwiftUI

enum Tab {
    case home
    case settings
}

struct MainView: View {
    @AppStorage("useDarkTheme") var useDarkTheme = false

    @AppStorage("followSystemTheme") var followSystemTheme = true

    @State var tabSelection: Tab = .home

    var body: some View {
        TabView {
           ContentView()
                .tabItem {
                    Label("Feed", systemImage: "newspaper")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .preferredColorScheme(followSystemTheme ? nil : (useDarkTheme ? .dark : .light))
        .accentColor(.primary)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
