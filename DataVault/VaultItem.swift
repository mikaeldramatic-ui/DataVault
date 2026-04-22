//
//  VaultItem.swift
//  DataVault
//
//  Created by Mikael Engvall on 2026-04-22.
//

import Foundation
import SwiftData

@Model
final class VaultItem: Identifiable {
    var id = UUID()
    var title: String
    var secretText: String
    var createdAt: Date

    init(title: String, secretText: String) {
        self.title = title
        self.secretText = secretText
        self.createdAt = Date()
    }
}
