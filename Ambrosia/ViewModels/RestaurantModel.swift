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


class RestaurantModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var restaurants = [Restaurant]()
    @Published var hasError = false
    @Published var error: RestaurantError?
    @Published var type: String?
    @Published var restaurantSelected: Int?
    @Published var loginSuccess = false
    @Published var currentRestaurantDetail: Restaurant?
    @Published var serviceOptions:[ServiceOptions]?
    @Published var diningOptions:[DiningOptions]?
    @Published var payments:[Payments]?
    @Published var planning:[Planning]?

    

    var firebaseService: FirebaseService = FirebaseService.services
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
        locationManager.distanceFilter = kCLDistanceFilterNone
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // stop auto zooming in apple map
        manager.stopUpdatingLocation()
        // store userLocation
        locations.last.map {
            currentUserCoordinate = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            userLocation = CalculateDistance.createCoordinateRegion(currentUserCoordinate!)

        }
        if currentUserCoordinate?.latitude == nil && ((currentUserCoordinate?.longitude) != nil) {
            currentUserCoordinate = CLLocationCoordinate2D(latitude: Constants.DEFAULT_LOCATION_LAT, longitude: Constants.DEFAULT_LOCATION_LNG)
            userLocation = CalculateDistance.createCoordinateRegion(currentUserCoordinate!)
        }

    }
    // MARK: Ask user location permission
    func requestGeolocationPermission() {
        // remember to open Info -> Target -> Info -> Below Bundle Version String -> Click add -> Type "Privacy - Location When In Use Usage Description" with value "Please allow us to access your location"
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }


    // MARK: Restaurant Navigation Method
    func navigateRestaurant(_ restId: String) {
        // find the index for the restaurant id
        currentRestaurantIndex = restaurants.firstIndex(where: {
            $0.placeId == restId
        }) ?? 0

        // set the current restaurant
        currentRestaurant = restaurants[currentRestaurantIndex]
    }

    // check if has popular restaurant
    //    func hasPopularRestaurant() -> Bool {
    //        for rest in restaurants {
    //            if (rest.isPopular()) {
    //                return true
    //            }
    //        }
    //        return false
    //    }

    func fetchDetail(restaurant: Restaurant) {
//        let urlString2 = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(place_id)&key=AIzaSyC2jWBSaP5fZLAuwlOc2mwcSBHfYXtv6hU"
//        let urlString2 = "https://tuananh131001.github.io/ambrosia_data.json"
//        print(urlString2)
//        if let url2 = URL(string: urlString2) {
//            URLSession.shared
//                .dataTask(with: url2) { data, response, error in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
//                        if error != nil {
//                            print ("error")
//                        } else {
//                            let decoder2 = JSONDecoder()
//                            //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                            if let data2 = data,
//                               let restaurantArr2 = try? decoder2.decode(Restaurant.self, from: data2) {
        self.currentRestaurantDetail = restaurant
        self.updateOptions()
        self.updateRestaurantDetailDistance()
        self.getType()

    }

    // Method to fetch all nearby restaurants
    func fetchRestaurant() {
        hasError = false
//        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=restaurant&location=10.73578300%2C106.69093400&radius=200&type=restaurant&key=AIzaSyC2jWBSaP5fZLAuwlOc2mwcSBHfYXtv6hU"
        let urlString = "https://tuananh131001.github.io/ambrosia_data.json"

        if let url = URL(string: urlString) {
            URLSession.shared
                .dataTask(with: url) { [weak self] data, response, error in

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if error != nil {
                    } else {

                        let decoder = JSONDecoder()
                        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                        if let data = data,
                            let restaurantArr = try? decoder.decode([Restaurant].self, from: data) {
                            print(restaurantArr[0])
                            self?.restaurants = restaurantArr
                            self?.calculateDistanceRest()

                        } else {
                            print("Cannot fetch all restaurant")
                        }
                    }
                }

            }.resume()
        }
    }

    func updateOptions() {
        for index in 0..<restaurants.count{
            self.serviceOptions = restaurants[index].additionalInfo?.serviceOptions
            self.diningOptions = restaurants[index].additionalInfo?.diningOptions
            self.planning = restaurants[index].additionalInfo?.planning
            self.payments = restaurants[index].additionalInfo?.payments
        }
    }
    
    func getServiceOptions(){
        for index in 0..<(serviceOptions?.count ?? 0){
            if serviceOptions?[index].delivery ?? false {
                
            }
        }
    }

    func chooseDefaultLocation() {
        if currentUserCoordinate?.latitude == nil && ((currentUserCoordinate?.longitude) == nil) {
            currentUserCoordinate = CLLocationCoordinate2D(latitude: Constants.DEFAULT_LOCATION_LAT, longitude: Constants.DEFAULT_LOCATION_LNG)
            userLocation = CalculateDistance.createCoordinateRegion(currentUserCoordinate!)
        }
    }

    func calculateDistanceRest() {
        for index in 0..<restaurants.count {
            restaurants[index].distance = CalculateDistance.calculateDistance(lat1: currentUserCoordinate?.latitude ?? Constants.DEFAULT_LOCATION_LAT, lon1: currentUserCoordinate?.longitude ?? Constants.DEFAULT_LOCATION_LNG, lat2: restaurants[index].location?.lat ?? 0, lon2: restaurants[index].location?.lng ?? 0)
            print(restaurants[index])
        }
    }

    func updateRestaurantDetailDistance() {
        currentRestaurantDetail?.distance = CalculateDistance.calculateDistance(lat1: currentUserCoordinate?.latitude ?? Constants.DEFAULT_LOCATION_LAT, lon1: currentUserCoordinate?.longitude ?? Constants.DEFAULT_LOCATION_LNG, lat2: currentRestaurantDetail?.location?.lat ?? 0, lon2: currentRestaurantDetail?.location?.lng ?? 0)
    }

    func findRestaurantById(_ id: String) -> Restaurant? {
        for index in 0..<restaurants.count {
            if (restaurants[index].placeId == id) {
                return restaurants[index]
            }
        }
        return nil
    }

    // Function to get current restaurant
    func getCurrentRestaurant(placeId: String) {
        for index in 0..<restaurants.count {
            if (restaurants[index].placeId == placeId) {
                currentRestaurantIndex = index
                break
            }
        }
        currentRestaurant = restaurants[currentRestaurantIndex]
    }

    // Function to update like for specific review
    func updateLikeForReview(id: UUID) {
        for i in 0..<(currentRestaurant?.reviews.count ?? 0) {
            if(currentRestaurant?.reviews[i].id == id) {
                currentRestaurant?.reviews[i].isLiked.toggle()
            }
        }
    }


    // Function to add new review from user
    func addReviewFromUser(reviewDescription: String, rating: Int, name: String, email: String, image: String) {
        let id = UUID()
        let date = Date.now
        let newReview = Review(id: id, reviewDescription: reviewDescription, dateCreated: date, rating: rating, username: name, email: email, image: "avatar1")
        self.currentRestaurantDetail?.reviews.append(newReview)
        print(self.currentRestaurantDetail as Any)
        firebaseService.addReviewToFirebase(restaurant: self.currentRestaurantDetail ?? Restaurant.testRestaurantDetail())
    }
    func updateReview(reviews: [Review]) {
        print(reviews)
        self.currentRestaurantDetail?.reviews = reviews
    }

    func getType(_ priceLv: Int? = -1) {
        // if price lv is default -> use restaurant detail's, else use custom
//        let priceLevel: Int?
//        if priceLv == -1 {
//             priceLevel = currentRestaurantDetail?.price_level
//        }
//        else {
//            priceLevel = priceLv
//        }
//
//        // define restaurant type based on price level
//        if (priceLevel == 0){
//            self.type = "Free"
//        }
//        else if (priceLevel == 1){
//            self.type = "Inexpensive"
//        }
//        else if (priceLevel == 2){
//            self.type = "Moderate"
//        }
//        else if (priceLevel == 3){
//            self.type = "Expensive"
//        }
//        else if (priceLevel == 4){
//            self.type = "Very Expensive"
//        }
//        else{
//            self.type = "Inexpensive"
//        }
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
