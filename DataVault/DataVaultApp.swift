//
//  DataVaultApp.swift
//  DataVault
//
//  Created by Mikael Engvall on 2026-04-22.
//

import SwiftUI
import SwiftData

@main
struct DataVaultApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: VaultItem.self)
    }
}
