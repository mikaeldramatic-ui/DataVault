//
//  ContentView.swift
//  DataVault
//
//  Created by Mikael Engvall on 2026-04-22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var title = ""
    @State private var secretText = ""
    @State private var items: [VaultItem] = []
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            List(items) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title).font(.headline)
                    Text(item.secretText).font(.subheadline).foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Data Vault")
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 8) {
                    TextField("Titel", text: $title)
                        .textFieldStyle(.roundedBorder)
                    TextField("Hemlig text", text: $secretText)
                        .textFieldStyle(.roundedBorder)
                    Button("Spara") {
                        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
                              !secretText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                            return
                        }

                        let newItem = VaultItem(title: title, secretText: secretText)
                        modelContext.insert(newItem)
                        items.append(newItem)

                        title = ""
                        secretText = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(.thinMaterial)
            }
        }
    }
}

#Preview {
    ContentView()
}
