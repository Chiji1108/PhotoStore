import Foundation
import SwiftData
import UIKit

@Model
final class PhotoItem {
    var id: UUID
    var name: String
    @Attribute(.externalStorage) var photoData: Data

    init(id: UUID = UUID(), name: String, photoData: Data) {
        self.id = id
        self.name = name
        self.photoData = photoData
    }

    static let preview: PhotoItem =
        PhotoItem(name: "Sample 1", photoData: UIImage(named: "IMG_0022")!.pngData()!)
}
