//
//  User.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 06/09/2022.
//

import Foundation
import SwiftUI

struct User: Decodable {
    var id: String
    var name: String
    var dob:Date
    var selectedGender:Int
    var favouriteRestaurants: [Restaurant] = [Restaurant]()
    var email:String
    var avatarStr: String
    var reviewRestaurant:[Restaurant] = [Restaurant]()
    var isDarkModeOn: Bool = false
}







