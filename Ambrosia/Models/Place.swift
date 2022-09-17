/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Nguyen Tuan Anh, Vo Quoc Huy
    ID: s3864077, s3823236
    Created  date: 10/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
*/

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
