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
 - https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift
 */

import Foundation
import CoreLocation
import MapKit


class RestaurantModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var restaurants: [Restaurant] = [Restaurant]()
    @Published var hasError = false
    @Published var error: RestaurantError?
    @Published var type: String?
    @Published var restaurantSelected: Int?
    @Published var loginSuccess = false
    @Published var sortedByRankRestaurants: [Restaurant] = [Restaurant]()
    @Published var sortedByDistanceRestaurants: [Restaurant] = [Restaurant]()
    @Published var districtRestaurants: [Restaurant] = [Restaurant]()
    @Published var firstTwentyRestaurants: [Restaurant] = [Restaurant]()

    var tempRestaurant: [Restaurant] = [Restaurant]()
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

    func fetchImageRestaurant() {
        let pathString = Bundle.main.path(forResource: "jsonformatter", ofType: "json")
        if let path = pathString {
            // Create a url object
            let url = URL(fileURLWithPath: path)
            //Error handling
            do {
                let data = try Data(contentsOf: url)
                //Parse the data
                let decoder = JSONDecoder()
                do {
                    let placeArr = try decoder.decode(Place.self, from: data)
                    for index in self.restaurants.indices {
                        let obj = placeArr.first(where: { $0.placeID == self.restaurants[index].placeId })
                        self.restaurants[index].imageLink = obj?.thumnail ?? "https://i.pinimg.com/200x/ff/50/2c/ff502c2d46373cc9908091efec8cfb11.jpg"
                    }
                    
                    self.restaurants = self.restaurants
                    self.calculateDistanceRest()
                    self.sortRestaurantDistance()
                    self.sortRestaurant()
                    self.getTwentyRestaurant()
                } catch {
                    print(error)
                }
            }
            catch {
                // execution will come here if an error is thrown
                print(error)
            }

        }
    }
    func fetchRestaurant() {
        let pathString = Bundle.main.path(forResource: "ambrosia_data", ofType: "json")
        if let path = pathString {
            // Create a url object
            let url = URL(fileURLWithPath: path)
            //Error handling
            do {
                let data = try Data(contentsOf: url)
                //Parse the data
                let decoder = JSONDecoder()
                do {
                    let restaurantArr = try decoder.decode([Restaurant].self, from: data)
                    self.restaurants = restaurantArr
                  
                    self.fetchImageRestaurant()
                } catch {
                    print(error)
                }
            }
            catch {
                // execution will come here if an error is thrown
                print(error)
            }

        }
    }
//    func fetchRestaurant() {
//        let testUrl = "https://tuananh131001.github.io/ambrosia_data.json"
//        //        fetchImageRestaurant(url: testUrl, placeId: "ChIJf1ud4fkudTERzkik9gwaXQU")
//        hasError = false
//        //        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=restaurant&location=10.73578300%2C106.69093400&radius=200&type=restaurant&key=AIzaSyC2jWBSaP5fZLAuwlOc2mwcSBHfYXtv6hU"
//        let urlString = "https://tuananh131001.github.io/ambrosia_data.json"
//
//        if let url = URL(string: urlString) {
//            URLSession.shared
//                .dataTask(with: url) { [weak self] data, response, error in
//                DispatchQueue.global(qos: .userInitiated).async {
//                    if error != nil {
//                    } else {
//                        let decoder = JSONDecoder()
//                        //                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                        if let data = data,
//                            var restaurantArr = try? decoder.decode([Restaurant].self, from: data) {
//                            self?.tempRestaurant = restaurantArr
//                            DispatchQueue.main.async {
//                                print("sjdjsdj")
//                                self?.firebaseService.fetchImageResFromFirebase(self!.tempRestaurant, completion: { newRestaurants in
//                                    self?.restaurants = newRestaurants
//                                    for i in 0..<20 {
//                                        self?.firstTwentyRestaurants.append(self?.restaurants[i])
//                                    }
////                                    self?.sortRestaurant()
////                                    self?.sortRestaurantDistance()
////                                    self?.getFirstTwentyRestaurants()
//                                    print("assign")
////                                    self?.getFirstTwentyRestaurants(newRestaurants:newRestaurants)
//                                })
//                                self?.calculateDistanceRest()
////                                self?.getFirstTwentyRestaurants()
//
//
//
//                            }
//                        } else {
//                            print("Cannot fetch all restaurant")
//                        }
//                    }
//                }
//
//            }.resume()
//        }
//    }

    func getTwentyRestaurant(){
        for r in restaurants{
            if firstTwentyRestaurants.count < 20 {
                firstTwentyRestaurants.append(r)
            }
        }
    }

    func getServiceOptions() {
        for index in 0..<(currentRestaurant?.additionalInfo?.serviceOptions?.count ?? 0) {
            if currentRestaurant?.additionalInfo?.serviceOptions?[index].delivery != nil {
                currentRestaurant?.serviceOptionsArr.append("Delivery")
            }
            if currentRestaurant?.additionalInfo?.serviceOptions?[index].dineIn != nil {
                currentRestaurant?.serviceOptionsArr.append("Dine in")

            }
            if currentRestaurant?.additionalInfo?.serviceOptions?[index].takeout != nil {
                currentRestaurant?.serviceOptionsArr.append("Take out")

            }

        }

    }

    func getFirstTwentyRestaurants(newRestaurants: [Restaurant]) {
        for r in newRestaurants {
            if firstTwentyRestaurants.count <= 20 {
                firstTwentyRestaurants.append(r)
            }
        }
    }

    func getDiningOptions() {
        for index in 0..<(currentRestaurant?.additionalInfo?.diningOptions?.count ?? 0) {
            if currentRestaurant?.additionalInfo?.diningOptions?[index].Breakfast != nil {
                currentRestaurant?.diningOptionsArr.append("Breakfast")
            }
            else if currentRestaurant?.additionalInfo?.diningOptions?[index].Dessert != nil {
                currentRestaurant?.diningOptionsArr.append("Dessert")

            }
            else if currentRestaurant?.additionalInfo?.diningOptions?[index].Dinner != nil {
                currentRestaurant?.diningOptionsArr.append("Dinner")

            }
            else if currentRestaurant?.additionalInfo?.diningOptions?[index].Lunch != nil {
                currentRestaurant?.diningOptionsArr.append("Lunch")

            }

        }

    }

    func filterRestaurantByDistrict(district: String) {
        districtRestaurants = restaurants.filter {
            $0.state == "\(district), Ho Chi Minh City"
        }
    }

    func getPaymentOptions() {
        for index in 0..<(currentRestaurant?.additionalInfo?.payments?.count ?? 0) {
            if currentRestaurant?.additionalInfo?.payments?[index].cashOnly != nil {
                currentRestaurant?.paymentsArr.append("Cash Only")
            }
            else if currentRestaurant?.additionalInfo?.payments?[index].creditCards != nil {
                currentRestaurant?.paymentsArr.append("Credit Cards")

            }
            else if currentRestaurant?.additionalInfo?.payments?[index].debitCards != nil {
                currentRestaurant?.paymentsArr.append("Debit Cards")

            }

        }

    }

    func getPlaningOptions() {
        for index in 0..<(currentRestaurant?.additionalInfo?.planning?.count ?? 0) {
            if currentRestaurant?.additionalInfo?.planning?[index].acceptReservations != nil {
                currentRestaurant?.planingArr.append("Accept Reservations")
            }
            else if currentRestaurant?.additionalInfo?.planning?[index].reservationRequired != nil {
                currentRestaurant?.planingArr.append("Reservation Required")
            }
        }

    }

    func calculateNumber(number: Int) -> CGFloat {
        var value: CGFloat = 0
        if (number == 5) {
            value = CGFloat(currentRestaurant?.reviewsDistribution?.fiveStar ?? 0) / CGFloat(currentRestaurant?.reviewsCount ?? 1) * 100
        }
        else if (number == 4) {
            value = CGFloat(currentRestaurant?.reviewsDistribution?.fourStar ?? 0) / CGFloat(currentRestaurant?.reviewsCount ?? 1) * 100
        }
        else if (number == 3) {
            value = CGFloat(currentRestaurant?.reviewsDistribution?.threeStar ?? 0) / CGFloat(currentRestaurant?.reviewsCount ?? 1) * 100
        }
        else if (number == 2) {
            value = CGFloat(currentRestaurant?.reviewsDistribution?.twoStar ?? 0) / CGFloat(currentRestaurant?.reviewsCount ?? 1) * 100
        }
        else if (number == 1) {
            value = CGFloat(currentRestaurant?.reviewsDistribution?.oneStar ?? 0) / CGFloat(currentRestaurant?.reviewsCount ?? 1) * 100
        }
        return value
    }

    func chooseDefaultLocation() {
        if currentUserCoordinate?.latitude == nil && ((currentUserCoordinate?.longitude) == nil) {
            currentUserCoordinate = CLLocationCoordinate2D(latitude: Constants.DEFAULT_LOCATION_LAT, longitude: Constants.DEFAULT_LOCATION_LNG)
            userLocation = CalculateDistance.createCoordinateRegion(currentUserCoordinate!)
        }
    }

    func sortRestaurant() {
        let temp: [Restaurant]
        temp = restaurants.sorted {
            $0.rank ?? 0 > $1.rank ?? 0
        }
        for t in temp {
            if (sortedByRankRestaurants.count <= 20) {
                sortedByRankRestaurants.append(t)
            }
        }
        sortedByRankRestaurants = sortedByRankRestaurants.sorted {
            $0.rank ?? 0 > $1.rank ?? 0
        }

    }

    func sortRestaurantDistance() {
        let temp: [Restaurant]
        temp = restaurants.sorted {
            $0.distance < $1.distance
        }
        for t in temp {
            if (sortedByDistanceRestaurants.count <= 20) {
                sortedByDistanceRestaurants.append(t)
            }
        }
        sortedByDistanceRestaurants = sortedByDistanceRestaurants.sorted {
            $0.distance < $1.distance
        }
        print(sortedByDistanceRestaurants)

    }

    func calculateDistanceRest() {
        for index in 0..<restaurants.count {
            restaurants[index].distance = CalculateDistance.calculateDistance(lat1: currentUserCoordinate?.latitude ?? Constants.DEFAULT_LOCATION_LAT, lon1: currentUserCoordinate?.longitude ?? Constants.DEFAULT_LOCATION_LNG, lat2: restaurants[index].location?.lat ?? 0, lon2: restaurants[index].location?.lng ?? 0)
        }
    }

    // MARK: function for calling restaurant
    func callRest() {
        // if have phone -> call action
//        if  != nil && !(restaurantModel.currentRestaurant?.phone!.matches("^[a-zA-Z]$") ?? false) {
        if let phone = self.currentRestaurant?.phone {
            let formattedString = "tel://" + phone.replacingOccurrences(of: "+84", with: "0").replacingOccurrences(of: " ", with: "-")
            guard let url = URL(string: formattedString) else { return }
            UIApplication.shared.open(url)
        }
    }

    func updateRestaurantDetailDistance() {
        currentRestaurant?.distance = CalculateDistance.calculateDistance(lat1: currentUserCoordinate?.latitude ?? Constants.DEFAULT_LOCATION_LAT, lon1: currentUserCoordinate?.longitude ?? Constants.DEFAULT_LOCATION_LNG, lat2: currentRestaurant?.location?.lat ?? 0, lon2: currentRestaurant?.location?.lng ?? 0)
    }
    func findRestaurantIndexById(_ id: String) -> Int {
        if let index = restaurants.firstIndex(where: { $0.placeId == id }) {
            // do something with foo
            return index
        } else {
            // item could not be found
            print("cannot find")
        }
        return 0
    }
    func findRestaurantById(_ id: String) -> Restaurant? {

        if let index = restaurants.first(where: { $0.placeId == id }) {
            // do something with foo
            return index
        } else {
            // item could not be found
            print("cannot find")
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

    func getCurrentRestaurantByDistance(placeId: String) {
        for index in 0..<districtRestaurants.count {
            if (districtRestaurants[index].placeId == placeId) {
                currentRestaurantIndex = index
                break
            }
        }
        currentRestaurant = districtRestaurants[currentRestaurantIndex]

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
    func addReviewFromUser(reviewDescription: String, rating: Int, name: String, email: String, userId: String, image: String,userModel:UserModel) {
        let id = UUID()
        let date = Date.now
        let newReview = Review(id: id, reviewDescription: reviewDescription, dateCreated: date, rating: rating, username: name, email: email, image: "avatar1")
        self.currentRestaurant?.reviews.append(newReview)
        userModel.user.reviewRestaurant.append(self.currentRestaurant ?? Restaurant.testRestaurantDetail())
        firebaseService.addReviewToFirebase(restaurant: self.currentRestaurant ?? Restaurant.testRestaurantDetail(), userId: userId)
    }
    func updateReview(reviews: [Review]) {
        print(reviews)
        self.currentRestaurant?.reviews = reviews
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
