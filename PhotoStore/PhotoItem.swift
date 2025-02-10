import CoreLocation
import Foundation
import SwiftData
import UIKit

@Model
final class PhotoItem {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var photoData: Data
    var latitude: Double?
    var longitude: Double?

    init(
        id: UUID = UUID(), name: String, photoData: Data, latitude: Double? = nil,
        longitude: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.photoData = photoData
        self.latitude = latitude
        self.longitude = longitude
    }

    static let preview: PhotoItem =
        PhotoItem(
            name: "Sample 1",
            photoData: UIImage(named: "IMG_0022")!.pngData()!,
            latitude: 35.6812,
            longitude: 139.7671)
}
