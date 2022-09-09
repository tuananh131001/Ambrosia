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
}

typealias Reviews = [Review]


struct Restaurants: Codable {
    var results:[Restaurant]
}
