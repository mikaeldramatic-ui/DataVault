//
//  ContentView.swift
//  DataVault
//
//  Created by Mikael Engvall on 2026-04-22.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedItem: VaultItem?
    @State private var editTitle = ""
    @State private var editSecretText = ""
    @State private var isShowingEditSheet = false
    @State private var title = ""
    @State private var secretText = ""
    @Query(sort: \VaultItem.createdAt, order: .reverse)
    private var items: [VaultItem]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            if items.isEmpty {
                ContentUnavailableView(
                    "Inget i valvet",
                    systemImage: "tray",
                    description: Text("Lägg till din första hemlighet")
                )
            } else {
                List {
                    ForEach(items) { item in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title).font(.headline)
                            Text(item.secretText)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .onTapGesture {
                            selectedItem = item
                            editTitle = item.title
                            editSecretText = item.secretText
                            isShowingEditSheet = true
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .navigationTitle("Data Vault")
        .sheet(isPresented: $isShowingEditSheet) {
            VStack(spacing: 12) {
                Text("Redigera")
                    .font(.headline)

                TextField("Titel", text: $editTitle)
                    .textFieldStyle(.roundedBorder)

                TextField("Hemlig text", text: $editSecretText)
                    .textFieldStyle(.roundedBorder)

                Button("Spara ändringar") {
                    guard let item = selectedItem else { return }

                    item.title = editTitle
                    item.secretText = editSecretText

                    isShowingEditSheet = false
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        
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
                    
                    title = ""
                    secretText = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(.thinMaterial)
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
