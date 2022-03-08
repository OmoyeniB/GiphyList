import Foundation

// MARK: - GifModel
struct GifModel: Codable {
   let data: [Giphy]
}

// MARK: - Giphy
struct Giphy: Codable  {
    let id: String?
    let url: String?
    let title: String?
    let source: String?
    let rating: String?
    let source_tld: String?
    let images: Images?
}

struct Images: Codable {
    let original: Original
}

struct Original: Codable {
    let url: String
}

