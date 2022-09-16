/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 24/07/2022
    Last modified: 07/08/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
*/

import Foundation
import CoreLocation
import FirebaseFirestoreSwift
//struct Restaurant: Codable {
//    var place_id: String
//    var name: String = ""
//    var opening_hours:OpeningHours?
//    var price_level:Int?
//    var photos: [Photos]?
//    var review = Reviews()
//    var formatted_address:String?
//    var rating: Double?
//    var vicinity: String?
//    var user_ratings_total: Int?
//    var geometry:Geometry?
//    var distance: Double = 0
//    enum CodingKeys: String, CodingKey {
//          case place_id
//          case name
//          case opening_hours
//          case price_level
//          case photos
//          case rating
//          case vicinity
//          case user_ratings_total
//
//            case geometry
//       }
//
//
////    func isPopular() -> Bool {
////        return rating >= 4.5
////    }
//
//    static func testRestaurant() -> Restaurant{
//        return Restaurant(place_id: "12345", name: "Nhà hàng Của Sir", opening_hours: OpeningHours(open_now: true), price_level: 2, photos: [Photos(photo_reference: "testRestaurant")], review: Review.testReviews(), formatted_address: "120 Sir street, Sir District, Sir Ward, Sir city", rating: 4.5,vicinity: "120 Sir street, Sir District, Sir Ward, Sir city",user_ratings_total: 4)
//    }
//
//
//}


//struct OpeningHours:Codable{
//    var open_now:Bool?
//}

struct Restaurant: Codable {
    var placeId: String?
    var title: String = ""
    var address: String?
    var phone: String?
//    var delivery:Bool?
//    var dine_in:Bool?
//    var opening_hours:OpeningHoursDetail?
//    var takeout:Bool?
//    var serves_wine:Bool?
//    var price_level:Int?
    var totalScore: Double?
    var rank: Int?
    var reviews = [Review]()
    var options = [String]()
    var location: Geometry?
    var imageUrls:[String]?
    var distance: Double = 0
    
    var isFavorite: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case placeId
        case address
        case phone
        case title
//          case delivery
//          case dine_in
//          case opening_hours
//          case takeout
//          case serves_wine
//          case price_level
        case imageUrls
        case totalScore
        case rank
        case location
    }
    static func testRestaurantDetail() -> Restaurant {
        return Restaurant(placeId: "1234", title: "$3241", address: "23213", phone: "4324", totalScore: 4.2, rank: 7, reviews: [], options: [], location: Geometry(lat: 32.12, lng: 110.21), imageUrls: [])
    }

}
struct Restaurants: Codable {
    var results: [Restaurant]
}

struct OpeningHoursDetail: Codable {
    var open_now: Bool?
    var weekday_text: [String]?
}

struct Photos: Codable {
    var photo_reference: String?
}

struct Geometry: Codable {
    var lat: Double?
    var lng: Double?
}
struct Review: Identifiable, Decodable {
    var id: UUID = UUID()
    var reviewDescription: String
    var dateCreated: Date
    var rating: Int
    var username: String
    var email: String
    var image: String
    var isLiked: Bool = false
    enum CodingKeys: String, CodingKey {
        case dateCreated
        case email
        case image
        case isLiked
        case rating
        case reviewDescription
        case username
    }
    static func testReviews() -> [Review] {
        let review1 = Review(reviewDescription: "hơi ngon", dateCreated: Date.now, rating: 4, username: "Sir", email: "Sir@gmail.com", image: "avatar1")
        let review2 = Review(reviewDescription: "hơi dở", dateCreated: Date.now, rating: 3, username: "Chó Sir", email: "ChóSir@gmail.com", image: "avatar2")
        let review3 = Review(reviewDescription: "hơi Sir", dateCreated: Date.now, rating: 2, username: "Lê Anh Sir", email: "LêAnhSir@gmail.com", image: "avatar3")
        let review4 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com", image: "avatar4")
        let review5 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com", image: "avatar4")
        let review6 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com", image: "avatar4")
        let review7 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com", image: "avatar4")
        var reviews: [Review] = []
        reviews.append(review1)
        reviews.append(review2)
        reviews.append(review3)
        reviews.append(review4)
        reviews.append(review5)
        reviews.append(review6)
        reviews.append(review7)

        return reviews
    }
}

typealias Reviews = [Review]

//struct RestaurantDetail: Codable {
//    var result:Restaurant
//}


struct Point: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
