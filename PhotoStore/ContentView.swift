//
//  ContentView.swift
//  PhotoStore
//
//  Created by 千々岩真吾 on 2025/02/08.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PhotoItem.name) private var photoItems: [PhotoItem]

    @State private var selectedItem: PhotosPickerItem?
    @State private var showingNameDialog = false
    @State private var newPhotoData: Data?
    @State private var newPhotoName: String = ""

    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationStack {
            List(photoItems) { item in
                NavigationLink(destination: PhotoDetailView(photoItem: item)) {
                    PhotoRowView(photoItem: item)
                }
            }
            .navigationTitle("写真コレクション")
            .toolbar {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images
                ) {
                    Image(systemName: "plus")
                }
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        newPhotoData = data
                        locationFetcher.start()  // 位置情報の取得を開始
                        showingNameDialog = true
                    }
                }
            }
            .alert("写真の名前を入力", isPresented: $showingNameDialog) {
                TextField("名前", text: $newPhotoName)
                Button("保存") {
                    if let data = newPhotoData {
                        let location = locationFetcher.lastKnownLocation
                        let newItem = PhotoItem(
                            name: newPhotoName,
                            photoData: data,
                            latitude: location?.latitude,
                            longitude: location?.longitude
                        )
                        modelContext.insert(newItem)
                        newPhotoName = ""
                        newPhotoData = nil
                    }
                }
                Button("キャンセル", role: .cancel) {
                    newPhotoName = ""
                    newPhotoData = nil
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: PhotoItem.self, inMemory: true)
}
