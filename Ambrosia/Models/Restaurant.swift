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
    var description: String = ""
    var tel: String = ""
    var openHour: String = ""
    var categories: [String] = [""]
    var coordinates: [Double] = [0.0, 0.0]
    var address: String = ""

    var rating: Double = 4
    // MARK: - methods
    func coordinateObject() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: coordinates[0], longitude: coordinates[1])
    }
    func isPopular() -> Bool {
        return rating >= 4.5
    }

    static func testData () -> Restaurant {
        // for display data in preview
        return Restaurant(
            id: 0,
            name: "Yeebo",
            description: "Our extensive menu of over 300 dishes is the quintessence of traditional Chinese cuisine. The menu offers a wide range of dishes from nutritious Hotpot to Dimsum, and signature roasted dishes such as Pecking duck, roasted goose, top-of-the-range abalone, and cheese baked lobster just to name a few.",
            tel: "028 5412 1313",
            openHour: "7AM – 2PM & 5PM – 10PM",
            categories: ["Dim Sum", "Hot Pot"],
            coordinates: [0.0, 0.0],
            address: "109 Tôn Dật Tiên",
            rating: 4
            ) 
    }
}



