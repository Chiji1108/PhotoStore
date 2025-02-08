//
//  PhotoRowView.swift
//  PhotoStore
//
//  Created by 千々岩真吾 on 2025/02/08.
//

import SwiftUI

struct PhotoRowView: View {
    let photoItem: PhotoItem

    var body: some View {
        HStack {
            if let uiImage = UIImage(data: photoItem.photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            Text(photoItem.name)
        }
    }
}

#Preview {
    PhotoRowView(photoItem: PhotoItem.preview)
}
