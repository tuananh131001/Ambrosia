//
//  User.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 06/09/2022.
//

import Foundation

struct User: Decodable {
    var id: String
    var name: String
    var dob:Date
    var selectedGender:Int
    var favouriteRestaurants: [Restaurant] = [Restaurant]()

}







