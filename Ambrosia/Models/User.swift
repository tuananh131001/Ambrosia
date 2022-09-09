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
    var reviews: [Review]
    
    // Function for testing
    static func testUser() -> User{
        let restaurant = Restaurant(
            place_id: "sir1",
            name: "Yeebo"
        )
        let reviews = [Review(restaurant: restaurant, reviewDescription: "bị sir khinh",score: 8)]
        return User(username: "sir", password: "sir123", favoriteRestaurants: [Restaurant(
            place_id: "sir2",
            name: "Yeebo"
            )],email: "huyne",reviews: reviews)
        
    }
}

struct Review: Decodable, Identifiable{
    var id = UUID()
    var restaurant: Restaurant
    var reviewDescription: String
    var score: Int
}



