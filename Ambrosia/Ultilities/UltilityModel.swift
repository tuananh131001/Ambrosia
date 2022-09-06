/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 05/08/2022
    Last modified: 07/08/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
- https://www.movable-type.co.uk/scripts/latlong.html
 */


import Foundation
import MapKit

struct UltilityModel {
    // MARK: - Map
    // Create region object
    static func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }

    // Convert coordinate to string to show routes for user
    static func convertCoordinateString(_ coordinate: CLLocationCoordinate2D) -> String {
        return "\(String(format: "%f", coordinate.latitude)),\(String(format: "%f", coordinate.longitude))"
//        return "\(coordinate.latitude.description),\(coordinate.latitude.description)"
    }

    // MARK: - String
    // Split string to array when meeting comma
    static func splitStringComma(_ str: String) -> [String] {
        return str.components(separatedBy: ", ")
    }

    // MARK: - Calculate distance
    // calculate distance from user location to a restaurant
    static func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {

        // Convert degrees to radians.
        let radianLon1 = lon1 * Double.pi / 180
        let radianLon2 = lon2 * Double.pi / 180
        let radianLat1 = lat1 * Double.pi / 180
        let radianLat2 = lat2 * Double.pi / 180

        // haversine formula
        let dlon = radianLon2 - radianLon1
        let dlat = radianLat2 - radianLat1
        let a = pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2)
            * pow(sin(dlon / 2), 2)

        // radius of the earch
        let r = 6371
        let finalResult = 2 * atan2(sqrt(a), sqrt(1 - a)) * Double(r)

        // return the result
        return(finalResult.isNaN ? 0.0 : finalResult)
    }
}
