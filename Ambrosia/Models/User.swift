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
import SwiftUI

struct User: Codable {
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







