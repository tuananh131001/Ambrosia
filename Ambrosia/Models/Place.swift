// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let title = try? newJSONDecoder().decode(Title.self, from: jsonData)

import Foundation

// MARK: - PlaceElement
struct PlaceElement: Codable {
    let thumnail: String
    let placeID: String

    enum CodingKeys: String, CodingKey {
        case thumnail
        case placeID = "placeId"
    }
}

typealias Place = [PlaceElement]
