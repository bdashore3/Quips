//
//  SettingsView.swift
//  Quips
//
//  Created by Brian Dashore on 6/19/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("useDarkTheme") var useDarkTheme = false
    @AppStorage("iCloudEnabled") var iCloudEnabled = false

    @AppStorage("followSystemTheme") var followSystemTheme = true

    @State private var showiCloudAlert = false

    var body: some View {
        NavView {
            Form {
                Section("Appearance") {
                    Toggle(isOn: $useDarkTheme) {
                        Text("Use dark theme")
                    }

                    Toggle(isOn: $followSystemTheme) {
                        Text("Follow system theme")
                    }
                }

                Section("Syncing") {
                    Toggle(isOn: $iCloudEnabled) {
                        Text("iCloud sync")
                    }
                    .onChange(of: iCloudEnabled) { _ in
                        showiCloudAlert.toggle()
                    }
                    .alert(isPresented: $showiCloudAlert) {
                        Alert(
                            title: Text(iCloudEnabled ? "Syncing enabled" : "Syncing disabled"),
                            message: Text("Changing this setting requires an app restart"),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                }

                Section("Information") {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .tint(.primary.opacity(colorScheme == .light ? 0.8 : 0.4))
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
