/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 2
    Author: Tran Mai Nhung
    ID: s3879954
    Created  date: 26/07/2022
    Last modified: 07/08/2022
    Acknowledgement:
- Canvas, CodeWithChris Course
- https://stackoverflow.com/questions/24534229/swift-modifying-arrays-inside-dictionaries
- https://stackoverflow.com/questions/37517829/get-distinct-elements-in-an-array-by-object-property
- https://stackoverflow.com/questions/21983559/opens-apple-maps-app-from-ios-app-with-directions
*/

import Foundation
import CoreLocation
import MapKit

class RestaurantModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var restaurants:[Restaurant] = [Restaurant]()
    @Published var hasError  = false
    @Published var error: RestaurantError?

    @Published var loginSuccess = false
    // MARK: Location
    var locationManager = CLLocationManager()
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    // Current user region and coordinate
    @Published var userLocation = MKCoordinateRegion()
    @Published var currentUserCoordinate: CLLocationCoordinate2D?
    // MARK: Current restaurant
    @Published var currentRestaurant: Restaurant?
    var currentRestaurantIndex = 0
    
    // MARK: Current Random Restaurant
    @Published var currentRandomRestaurant: Restaurant?
    
   
    // MARK: init
    override init() {
        // Init method of NSObject
        super.init()
        fetchRestaurant()

        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        // set current random restaurant
        currentRandomRestaurant = restaurants.randomElement()
    }
    
    // MARK: - Location Methods
    //MARK:  Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus

        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            // after getting permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            print("No Permission")
        }
    }

    // MARK: Location manager
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // stop auto zooming in apple map
//        manager.stopUpdatingLocation()
//        // store userLocation
//        locations.last.map {
//            currentUserCoordinate = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
//            userLocation = UltilityModel.createCoordinateRegion(currentUserCoordinate!)
//
//            // display recent restaurants inside the regions
////            currentRegion = userLocation
//        }
//
//    }
    // MARK: Ask user location permission
    func requestGeolocationPermission() {
        // remember to open Info -> Target -> Info -> Below Bundle Version String -> Click add -> Type "Privacy - Location When In Use Usage Description" with value "Please allow us to access your location"
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // open apple map to show routes to the user
//    func openAppleMap(endCoordinate: CLLocationCoordinate2D) {
//        // create url to open apple map having route from current location to place
//        let routeURL = "http://maps.apple.com/?saddr=\(UltilityModel.convertCoordinateString(currentUserCoordinate ?? CLLocationCoordinate2D()))&daddr=\(UltilityModel.convertCoordinateString(endCoordinate))"
//        // binding
//        guard let url = URL(string: routeURL) else {
//            return
//        }
//        // open apple map based on the ios version
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
//    }
    

    // MARK: Restaurant Navigation Method
    func navigateRestaurant(_ restId: String) {
        // find the index for the restaurant id
        currentRestaurantIndex = restaurants.firstIndex(where: {
            $0.place_id == restId
        }) ?? 0
        
        // set the current restaurant
        currentRestaurant = restaurants[currentRestaurantIndex]
    }
    
    // check if has popular restaurant
    func hasPopularRestaurant() -> Bool {
        for rest in restaurants {
            if (rest.isPopular()) {
                return true
            }
        }
        return false
    }
    
    func fetchDetail(place_id:String) -> Restaurant {
        var restaurantDetail:Restaurant = Restaurant(place_id: "")
        let urlString = " https://maps.googleapis.com/maps/api/place/details/json?place_id=\(place_id)&key=AIzaSyBtCts3HUN6SLrVPBY8LLsm4rNnleUtvZY"
        if let url = URL(string: urlString) {
            URLSession.shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if error != nil {
                        print ("error")
                    } else {
                        let decoder = JSONDecoder()
                        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let data = data,
                           let restaurantArr = try? decoder.decode(RestaurantDetail.self, from: data) {
                            print(restaurantArr)
                            restaurantDetail.formatted_address = restaurantArr.result.formatted_address
                        }
                        else {
                            print("notthing")
                        }
                    }
                }
            }.resume()

        }
        return restaurantDetail
    }

    // Method to fetch all nearby restaurants
    func fetchRestaurant() {
        hasError = false
   
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=restaurant&location=10.73578300%2C106.69093400&radius=1500&type=restaurant&key=AIzaSyBtCts3HUN6SLrVPBY8LLsm4rNnleUtvZY"
        
//    https://maps.googleapis.com/maps/api/place/findplacefromtext/json
//      ?fields=formatted_address%2Cname%2Crating%2Copening_hours%2Cgeometry
//      &input=mongolian
//      &inputtype=textquery
//      &locationbias=circle%3A2000%4047.6918452%2C-122.2226413
//      &key=AIzaSyBtCts3HUN6SLrVPBY8LLsm4rNnleUtvZY
//        let urlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: urlString) {
            URLSession.shared
                .dataTask(with: url) { [weak self] data, response, error in

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        if error != nil {
                        print ("error")
                    } else {
                        let decoder = JSONDecoder()
                        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let data = data,
                            let restaurantArr = try? decoder.decode(Restaurants.self, from: data) {
//                            print(restaurantArr)
                            print(restaurantArr.results)
                            self?.restaurants = restaurantArr.results
                        }
                        else {
                            print("notthing")
                        }
                    }
                }
            }.resume()

        }

    }
    func addReviewFromUser(reviewDescription:String,rating:Int,username:String,email:String){
        let id = UUID()
        let date = Date.now
        let newReview = Review(id: id, reviewDescription: reviewDescription, dateCreated: date, rating: rating, username: username,email: email)
        restaurants[0].review.append(newReview)
    }
}


extension RestaurantModel {
    enum RestaurantError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        var errorDescription: String? {
            switch self {
            case.failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
