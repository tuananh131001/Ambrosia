/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Vo Quoc Huy, Tran Nguyen Ha Khanh, Tran Mai Nhung
 ID: s3864077, s3823236, s3877707, s3879954
 Created  date: 6/09/2022
 Last modified: 15/09/2022
 Acknowledgement:
 - Canvas
 */

import Foundation
import CoreLocation
import FirebaseFirestoreSwift

// MARK: - restaurant
struct Restaurant: Codable {
    var placeId: String?
    var title: String = ""
    var address: String?
    var phone: String?
    var categories: [String]?
    var categoryName: String?
    var state: String?
    var additionalInfo: AdditionalInfo?
    var openingHours: [OpeningHours]?
    var totalScore: Double?
    var rank: Int?
    var reviews = [Review]()
    var location: Location?
    var url: String?
    var distance: Double = 0
    var temporarilyClosed: Bool?
    var reviewsCount: Int?
    var reviewsDistribution: ReviewsDistribution?
    var serviceOptionsArr = [String]()
    var diningOptionsArr = [String]()
    var paymentsArr = [String]()
    var planingArr = [String]()
    var imageLink: String = ""
    
    // for decode and fetch
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
        case url
        case temporarilyClosed
        case reviewsCount
        case reviewsDistribution
    }
    // test
    static func testRestaurantDetail() -> Restaurant {
        return Restaurant(placeId: "3123", title: "3221", address: "3213123", phone: "#2213", totalScore: 10.0, rank: 1, reviews: [], location: Location.testLocation(), distance: 0.5)
        //        return Restaurant(placeId: "23123", title: "SIr", address: "Sir street, Sir city, Sir country", phone: "09301293910", categories: ["chinese"], categoryName: "korean food", additionalInfo: AdditionalInfo.testAdditionalInfo(), openingHours: OpeningHours.testOpeningHours(), totalScore: 10, rank: 1, reviews: [], location: Location.testLocation(), imageUrls: ["testRestaurant"], distance: 0, temporarilyClosed: true, reviewsCount: 10, reviewsDistribution: ReviewsDistribution.testReviewsDistribution())
    }
    
}
// MARK:  list of restaurants
struct Restaurants: Codable {
    var results: [Restaurant]
}

// MARK: open hours in restaurant detail
struct OpeningHours: Codable {
    var day: String
    var hours: String
    static func testOpeningHours() -> OpeningHours {
        return OpeningHours(day: "Sunday", hours: "4.30pm")
    }
}

// MARK: additional options in restaurant detail
struct AdditionalInfo: Codable {
    var serviceOptions: [ServiceOptions]?
    var diningOptions: [DiningOptions]?
    var planning: [Planning]?
    var payments: [Payments]?
    
    // for fetching
    enum CodingKeys: String, CodingKey {
        case planning = "Planning"
        case diningOptions = "Dining options"
        case serviceOptions = "Service options"
        case payments = "Payments"
    }
    //test
    static func testAdditionalInfo() -> AdditionalInfo {
        return AdditionalInfo(serviceOptions: [ServiceOptions.testServiceOptions()], diningOptions: [DiningOptions.testDiningOptions()], planning: [Planning.testPlanning()], payments: [Payments.testPayments()])
    }
}

// MARK: payment method in restaurant detail
struct Payments: Codable {
    var cashOnly: Bool?
    var debitCards: Bool?
    var creditCards: Bool?
    // for fetching
    enum CodingKeys: String, CodingKey {
        case cashOnly = "Cash-only"
        case debitCards = "Debit cards"
        case creditCards = "Credit cards"
    }
    static func testPayments() -> Payments {
        return Payments(cashOnly: true, debitCards: true, creditCards: true)
    }
}

// MARK: service option in restaurant detail
struct ServiceOptions: Codable {
    var delivery: Bool?
    var takeout: Bool?
    var dineIn: Bool?
    // fetching
    enum CodingKeys: String, CodingKey {
        case delivery = "Delivery"
        case takeout = "Takeout"
        case dineIn = "Dine-in"
    }
    // test
    static func testServiceOptions() -> ServiceOptions {
        return ServiceOptions(delivery: true, takeout: true, dineIn: true)
    }
}
// MARK: dining option in restaurant detail
struct DiningOptions: Codable {
    var Lunch: Bool?
    var Dinner: Bool?
    var Breakfast: Bool?
    var Dessert: Bool?
    static func testDiningOptions() -> DiningOptions {
        return DiningOptions(Lunch: true, Dinner: true, Breakfast: true, Dessert: true)
    }
}

// MARK: planning option in restaurant detail
struct Planning: Codable {
    var acceptReservations: Bool?
    var reservationRequired: Bool?
    enum CodingKeys: String, CodingKey {
        case acceptReservations = "Accepts reservations"
        case reservationRequired = "Reservations required"
    }
    static func testPlanning() -> Planning {
        return Planning(acceptReservations: true)
    }
}
// MARK: reviews in restaurant detail
struct ReviewsDistribution: Codable {
    var oneStar: Int?
    var twoStar: Int?
    var threeStar: Int?
    var fourStar: Int?
    var fiveStar: Int?
    static func testReviewsDistribution() -> ReviewsDistribution {
        return ReviewsDistribution(oneStar: 2, twoStar: 1, threeStar: 3, fourStar: 4, fiveStar: 2)
    }
}
// MARK: restaurant location
struct Location: Codable {
    var lat: Double?
    var lng: Double?
    static func testLocation() -> Location {
        return Location(lat: 10, lng: 100)
    }
}

// MARK: - Reviee
struct Review: Identifiable, Decodable {
    var id: UUID = UUID()
    var reviewDescription: String
    var dateCreated: Date
    var rating: Int
    var email: String
    var isLiked: Bool = false
    var userId: String
    // for fetching
    enum CodingKeys: String, CodingKey {
        case dateCreated
        case email
        case isLiked
        case rating
        case reviewDescription
        case userId
    }
    // for test
    static func testReviews() -> [Review] {
        let review1 = Review(reviewDescription: "hơi ngon", dateCreated: Date.now, rating: 4, email: "Sir@gmail.com", userId: "avatar1")
        let review2 = Review(reviewDescription: "hơi dở", dateCreated: Date.now, rating: 3, email: "ChóSir@gmail.com", userId: "avatar1")
        let review3 = Review(reviewDescription: "hơi Sir", dateCreated: Date.now, rating: 2, email: "LêAnhSir@gmail.com", userId: "avatar1")
        let review4 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, email: "TheKing@gmail.com", userId: "avatar1")
        let review5 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, email: "TheKing@gmail.com", userId: "avatar1")
        let review6 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, email: "TheKing@gmail.com", userId: "avatar1")
        let review7 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, email: "TheKing@gmail.com", userId: "avatar1")
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

// MARK: - Point
struct Point: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
