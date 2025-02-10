//
//  PhotoDetailView.swift
//  PhotoStore
//
//  Created by 千々岩真吾 on 2025/02/08.
//

import MapKit
import SwiftUI

struct PhotoDetailView: View {
    let photoItem: PhotoItem
    @State private var viewMode = ViewMode.photo

    enum ViewMode: Int {
        case photo = 0
        case both = 1
        case map = 2
    }

    var body: some View {
        VStack {
            Picker("表示モード", selection: $viewMode) {
                Image(systemName: "photo").tag(ViewMode.photo)
                Image(systemName: "square.split.1x2").tag(ViewMode.both)
                Image(systemName: "map").tag(ViewMode.map)
            }
            .pickerStyle(.segmented)
            .padding()

            TabView(selection: $viewMode) {
                photoView
                    .tag(ViewMode.photo)

                GeometryReader { geometry in
                    VStack(spacing: 0) {
                        photoView
                            .frame(height: geometry.size.height / 2)
                        mapView
                            .frame(height: geometry.size.height / 2)
                    }
                }
                .tag(ViewMode.both)

                mapView
                    .tag(ViewMode.map)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationTitle(photoItem.name)
    }

    var photoView: some View {
        Group {
            if let uiImage = UIImage(data: photoItem.photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        }
    }

    var mapView: some View {
        Group {
            if let latitude = photoItem.latitude,
                let longitude = photoItem.longitude
            {
                Map(initialPosition: .region(region(latitude: latitude, longitude: longitude))) {
                    Marker(
                        photoItem.name,
                        coordinate: CLLocationCoordinate2D(
                            latitude: latitude,
                            longitude: longitude
                        ))
                }
            } else {
                ContentUnavailableView(
                    "位置情報なし",
                    systemImage: "location.slash",
                    description: Text("この写真には位置情報が記録されていません"))
            }
        }
    }

    private func region(latitude: Double, longitude: Double) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
}

#Preview {
    NavigationStack {
        PhotoDetailView(photoItem: PhotoItem.preview)
    }
}
