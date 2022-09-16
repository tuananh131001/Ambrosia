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
    var categories:[String]?
    var categoryName:String?
    var state:String?
    var additionalInfo:AdditionalInfo?
    var openingHours:[OpeningHours]?
    var totalScore: Double?
    var rank: Int?
    var reviews = [Review]()
    var location: Location?
    var imageUrls:[String]?
    var distance: Double = 0
    var temporarilyClosed:Bool?
    var reviewsCount:Int?
    var reviewsDistribution:ReviewsDistribution?
    var serviceOptionsArr = [String]()
    var diningOptionsArr = [String]()
    var paymentsArr = [String]()
    var planingArr = [String]()

    
    enum CodingKeys: String, CodingKey {
        case placeId
        case address
        case phone
        case title
        case categories
        case categoryName
        case state
        case additionalInfo
        case openingHours
        case totalScore
        case rank
        case location
        case imageUrls
        case temporarilyClosed
        case reviewsCount
        case reviewsDistribution
    }
    static func testRestaurantDetail() -> Restaurant {
        return Restaurant(placeId: "3123", title: "3221", address: "3213123", phone: "#2213", totalScore: 10.0, rank: 1, reviews: [], location: Location.testLocation(), imageUrls: ["testRestaurant"], distance: 0.5)
//        return Restaurant(placeId: "23123", title: "SIr", address: "Sir street, Sir city, Sir country", phone: "09301293910", categories: ["chinese"], categoryName: "korean food", additionalInfo: AdditionalInfo.testAdditionalInfo(), openingHours: OpeningHours.testOpeningHours(), totalScore: 10, rank: 1, reviews: [], location: Location.testLocation(), imageUrls: ["testRestaurant"], distance: 0, temporarilyClosed: true, reviewsCount: 10, reviewsDistribution: ReviewsDistribution.testReviewsDistribution())
    }

}
struct Restaurants: Codable {
    var results: [Restaurant]
}

struct OpeningHours: Codable {
    var day: String
    var hours: String
    static func testOpeningHours() -> OpeningHours{
        return OpeningHours(day: "Sunday", hours: "4.30pm")
    }
}



struct AdditionalInfo:Codable{
    var serviceOptions: [ServiceOptions]?
    var diningOptions: [DiningOptions]?
    var planning:[Planning]?
    var payments:[Payments]?
    enum CodingKeys: String, CodingKey {
        case planning = "Planning"
        case diningOptions = "Dining options"
        case serviceOptions = "Service options"
        case payments = "Payments"
    }
    static func testAdditionalInfo() -> AdditionalInfo{
        return AdditionalInfo(serviceOptions: [ServiceOptions.testServiceOptions()], diningOptions: [DiningOptions.testDiningOptions()], planning: [Planning.testPlanning()], payments: [Payments.testPayments()])
    }
}

struct Payments: Codable{
    var cashOnly: Bool?
    var debitCards:Bool?
    var creditCards:Bool?
    enum CodingKeys: String, CodingKey {
        case cashOnly = "Cash-only"
        case debitCards = "Debit cards"
        case creditCards = "Credit cards"
    }
    static func testPayments() -> Payments{
        return Payments(cashOnly: true, debitCards: true, creditCards: true)
    }
}


struct ServiceOptions: Codable{
    var delivery: Bool?
    var takeout:Bool?
    var dineIn:Bool?
    enum CodingKeys: String, CodingKey {
        case delivery = "Delivery"
        case takeout = "Takeout"
        case dineIn = "Dine-in"
    }
    static func testServiceOptions() -> ServiceOptions{
        return ServiceOptions(delivery: true, takeout: true, dineIn: true)
    }
}

struct DiningOptions:Codable {
    var Lunch:Bool?
    var Dinner:Bool?
    var Breakfast:Bool?
    var Dessert:Bool?
    static func testDiningOptions() -> DiningOptions{
        return DiningOptions(Lunch: true, Dinner: true, Breakfast: true, Dessert: true)
    }
}

struct Planning: Codable{
    var acceptReservations:Bool?
    var reservationRequired:Bool?
    enum CodingKeys: String, CodingKey {
        case acceptReservations = "Accepts reservations"
        case reservationRequired = "Reservations required"
    }
    static func testPlanning() -> Planning{
        return Planning(acceptReservations: true)
    }
}

struct ReviewsDistribution:Codable{
    var oneStar:Int?
    var twoStar:Int?
    var threeStar:Int?
    var fourStar:Int?
    var fiveStar:Int?
    static func testReviewsDistribution() -> ReviewsDistribution{
        return ReviewsDistribution(oneStar: 2, twoStar: 1, threeStar: 3, fourStar: 4, fiveStar: 2)
    }
}

struct Location:Codable{
    var lat:Double?
    var lng:Double?
    static func testLocation() -> Location{
        return Location(lat: 10, lng: 100)
    }
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


struct Point: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
