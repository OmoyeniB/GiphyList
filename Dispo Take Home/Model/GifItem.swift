import Foundation

struct GifItem: Codable {
    let data: GifObject?
}

struct GifObject: Codable {
    let type: String?
    let rating: String?
    let id: String?
    let source_tld: String?
    let url: String?
    let title: String?
    let images: GifImage?
}

struct GifImage: Codable {
    let frames: String?
    let height: String?
    let original: OriginalImage?
}

struct OriginalImage: Codable {
    let url: String
}

