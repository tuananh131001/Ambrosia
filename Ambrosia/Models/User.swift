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
            id: 0,
            name: "Yeebo",
            description: "Our extensive menu of over 300 dishes is the quintessence of traditional Chinese cuisine. The menu offers a wide range of dishes from nutritious Hotpot to Dimsum, and signature roasted dishes such as Pecking duck, roasted goose, top-of-the-range abalone, and cheese baked lobster just to name a few.",
            tel: "028 5412 1313",
            openHour: "7AM – 2PM & 5PM – 10PM",
            categories: ["Dim Sum", "Hot Pot"],
            coordinates: [0.0, 0.0],
            address: "109 Tôn Dật Tiên",
            rating: 4,
            foodList: [Food.testData()])
        let reviews = [Review(restaurant: restaurant, reviewDescription: "bị sir khinh",score: 8)]
        return User(username: "sir", password: "sir123", favoriteRestaurants: [Restaurant(
            id: 0,
            name: "Yeebo",
            description: "Our extensive menu of over 300 dishes is the quintessence of traditional Chinese cuisine. The menu offers a wide range of dishes from nutritious Hotpot to Dimsum, and signature roasted dishes such as Pecking duck, roasted goose, top-of-the-range abalone, and cheese baked lobster just to name a few.",
            tel: "028 5412 1313",
            openHour: "7AM – 2PM & 5PM – 10PM",
            categories: ["Dim Sum", "Hot Pot"],
            coordinates: [0.0, 0.0],
            address: "109 Tôn Dật Tiên",
            rating: 4,
            foodList: [Food.testData()])], email: "leanhsir@gmail.com", reviews: reviews)
        
    }
}

struct Review: Decodable, Identifiable{
    var id = UUID()
    var restaurant: Restaurant
    var reviewDescription: String
    var score: Int
}



