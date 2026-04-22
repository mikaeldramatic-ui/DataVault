//
//  ContentView.swift
//  DataVault
//
//  Created by Mikael Engvall on 2026-04-22.
//

import SwiftUI

struct ContentView: View {
    @State private var title = ""
    @State private var secretText = ""
    @State private var items: [VaultItem] = []

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
                        print("TODO: Spara till SwiftData")
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
