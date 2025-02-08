//
//  PhotoStoreApp.swift
//  PhotoStore
//
//  Created by 千々岩真吾 on 2025/02/08.
//

import SwiftData
import SwiftUI

@main
struct PhotoStoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: PhotoItem.self)
    }
}
