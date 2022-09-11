//
//  User.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 06/09/2022.
//

import Foundation

struct User: Decodable{
    var username: String
    var password: String
    var favoriteRestaurants: [Restaurant]
    var email:String
    var image:String
    
    // Function for testing
    static func testUser() -> User{
//        let geometry = Geometry(location: Location(lat: 10, lng: 100))

        let restaurant = Restaurant(
            place_id: "sir1",
            name: "Yeebo",
            opening_hours: OpeningHours(open_now: false),
            price_level: 2
        )
//        let reviews = [Review(restaurant: restaurant, reviewDescription: "bị sir khinh",score: 8)]
        return User(username: "sir", password: "sir123", favoriteRestaurants: [restaurant
            ],email: "huyne",image: "avatar1")
        
    }
}







