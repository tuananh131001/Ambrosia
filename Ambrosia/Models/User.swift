//
//  User.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 06/09/2022.
//

import Foundation

struct User: Decodable{
    var user: String
    var password: String
    var favoriteRestaurants: [Restaurant]
    var email:String
    
    // Function for testing
    static func testUser() -> User{
//        let geometry = Geometry(location: Location(lat: 10, lng: 100))
        let user = User(user: "Sir", password: "Sir ne", favoriteRestaurants: [], email: "sir@gmail.com")
        let restaurant = Restaurant(
            place_id: "sir1",
            name: "Yeebo",
            opening_hours: OpeningHours(open_now: false),
            vicinity: "70 nhà Sir",
            price_level: 2
            
        )
//        let reviews = [Review(restaurant: restaurant, reviewDescription: "bị sir khinh",score: 8)]
        return User(user: "sir", password: "sir123", favoriteRestaurants: [restaurant
            ],email: "huyne")
        
    }
}







