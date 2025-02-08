//
//  PhotoDetailView.swift
//  PhotoStore
//
//  Created by 千々岩真吾 on 2025/02/08.
//

import SwiftUI

struct PhotoDetailView: View {
    let photoItem: PhotoItem

    var body: some View {
        if let uiImage = UIImage(data: photoItem.photoData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .navigationTitle(photoItem.name)
        }
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photoItem: PhotoItem.preview)
    }
}
