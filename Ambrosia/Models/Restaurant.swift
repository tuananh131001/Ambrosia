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
//    var description: String = ""
//    var tel: String = ""
//    var openHour: String = ""
//    var categories: [String] = [""]
//    var coordinates: [Double] = [0.0, 0.0]
//    var address: String = ""

    var rating: Double = 4
    // MARK: - methods
//    func coordinateObject() -> CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
//    }
    func isPopular() -> Bool {
        return rating >= 4.5
    }

   
}



