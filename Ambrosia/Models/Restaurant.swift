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

struct Restaurant: Codable {
    var place_id: String
    var name: String = ""
    var opening_hours:OpeningHours?
    var vicinity:String?
    var price_level:Int?
    var photos: [Photos]?
    var review = Reviews()
    enum CodingKeys: String, CodingKey {
          case place_id
          case name
          case opening_hours
          case vicinity
          case price_level
          case photos
       }


    var rating: Double = 4

    func isPopular() -> Bool {
        return rating >= 4.5
    }

   
}


struct OpeningHours:Codable{
    var open_now:Bool?
}

struct Photos:Codable{
    var photo_reference: String?
}

struct Review:Identifiable{
    var id = UUID()
    var reviewDescription: String
    var dateCreated:Date
    var rating: Int
    var username:String
    var email:String
    var image:String
    var isLiked:Bool = false
    
    static func testReviews()->[Review]{
        let review1 = Review(reviewDescription: "hơi ngon", dateCreated: Date.now, rating: 4, username: "Sir", email: "Sir@gmail.com",image: "avatar1")
        let review2 = Review(reviewDescription: "hơi dở", dateCreated: Date.now, rating: 3, username: "Chó Sir", email: "ChóSir@gmail.com",image: "avatar2")
        let review3 = Review(reviewDescription: "hơi Sir", dateCreated: Date.now, rating: 2, username: "Lê Anh Sir", email: "LêAnhSir@gmail.com",image: "avatar3")
        let review4 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com",image: "avatar4")
        let review5 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com",image: "avatar4")
        let review6 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com",image: "avatar4")
        let review7 = Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com",image: "avatar4")
        var reviews:[Review] = []
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


struct Restaurants: Codable {
    var results:[Restaurant]
}
