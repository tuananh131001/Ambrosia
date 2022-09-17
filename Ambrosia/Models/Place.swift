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
