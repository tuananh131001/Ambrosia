/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Vo Quoc Huy, Tran Mai Nhung
    ID: s3823236, s3879954
    Created  date: 6/09/2022
    Last modified: 15/09/2022
    Acknowledgement:
    - Canvas
    - https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
*/

import Foundation
import MapKit


struct CalculateDistance {
    // MARK: - create calculate distance based on long, lat
    static func deg2rad(_ deg: Double) -> Double {
        return deg * (Double.pi / 180)
    }
    static func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {

        let r = 6371; // Radius of the earth in km
        let dLat = deg2rad(lat2 - lat1); // deg2rad below
        let dLon = deg2rad(lon2 - lon1);
        let a =
            sin(dLat / 2) * sin(dLat / 2) +
            cos(deg2rad(lat1)) * cos(deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2)
        ;
        let c = 2 * atan2(sqrt(a), sqrt(1 - a));
        let d = Double(r) * c; // Distance in km
        return d;
    }


    // MARK: - create coordinate based  on the long and lat double
    static func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }

}
