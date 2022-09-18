/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Nguyen Tuan Anh, Vo Quoc Huy, Tran Nguyen Ha Khanh, Tran Mai Nhung
    ID: s3864077, s3823236, s3877707, s3879954
    Created  date: 14/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
    -  https://stackoverflow.com/questions/60225869/how-do-i-return-an-object-from-a-document-stored-in-firestore-swift
    -         https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
*/


import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseDatabase
import SwiftUI

class FirebaseService: ObservableObject {
    static let services = FirebaseService()

//    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false

    // MARK: sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String, user: UserModel) {
        // check if empty string email, pass
        if (email == "" || password == "" || passwordConfirmation == "") {
            self.signUpMessage = "Please fill in all the fields"
        }
        // validate pass format
        else if (password.count < 6) {
            self.signUpMessage = "Password must be at least 6 characters"
        }
        // if not same pass
        else if (passwordConfirmation != password) {
            self.signUpMessage = "Confirm password doesn't match"
        }
        // login success
        else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // if error due to email
                if error != nil {
                    let msg = error?.localizedDescription ?? ""
                    if (msg.contains("email address is badly formatted")) {
                        self.signUpMessage = "Invalid email address"
                    }
                    else if (msg.contains("email address is already in use")) {
                        self.signUpMessage = "This email address is already in use"
                    }
                    else {
                        self.signUpMessage = "Sign up unsuccessfully"
                    }
                } else {
                    // login success
                    self.signUpMessage = "Sign up successfully"
                    guard let userID = authResult?.user.uid else { return }
                    // add to firestore
                    Firestore.firestore().collection("user").document(userID).setData([
                        "name": "Sir",
                        "email": authResult?.user.email ?? ""
                        ]) { err in
                        if err != nil {
                        } else {
                        }
                    }
                    // back to sign in page
                    user.loginSuccess = true
                    user.isNewUser = true
                    self.signUpSuccess = true
                }
            }
        }
    }

    // MARK: change user info in firestore
    func updateUser(user: User) {
//        Firestore.firestore().collection("user").document(user.id).setData(["name": user.name, "dob": user.dob, "gender": user.selectedGender, "favoriteRestaurants": user.favouriteRestaurants, "isDarkModeOn": user.isDarkModeOn, "avatarStr": user.avatarStr], merge: true)
        do {
            try Firestore.firestore().collection("user").document(user.id).setData(from: user, merge: true)
        }
        catch {
            print("UPDATE USER FAILED : updateUser()")
        }
    }
    
    // MARK: add image to firestore
    func addPlaceImage(placeId: String, imageLink: String) {
        Firestore.firestore().collection("restaurant").document(placeId).setData(["ImageLink": imageLink], merge: true)
    }
    
    // MARK: add review
    func addReviewToFirebase(restaurant: Restaurant, userId: String) {
        Firestore.firestore().collection("restaurant").document(restaurant.placeId ?? "").setData(["created": true], merge: true)
        var newReviewList: [[String: Any]] = []
        // get each reviews put in dictionary for uploading
        for riviu in restaurant.reviews {
            let newReview = ["reviewDescription": riviu.reviewDescription, "dateCreated": riviu.dateCreated, "rating": riviu.rating, "email": riviu.email, "isLiked": riviu.isLiked, "userId": riviu.userId] as [String: Any]
            newReviewList.append(newReview)
        }
        // assign new data to firestore
        Firestore.firestore().collection("restaurant").document(restaurant.placeId ?? "").updateData([
            "reviews": newReviewList
            ])
        // update user review of that restaurant
        Firestore.firestore().collection("user").document(userId).updateData(["reviewRestaurant": FieldValue.arrayUnion([restaurant.placeId ?? ""])])
    }
    
    // MARK: get review from firestore
    func fetchReviewFromFirebase(restaurant: Restaurant, model: RestaurantModel) {
        let docRef = Firestore.firestore().collection("restaurant").document(restaurant.placeId ?? "")
        //https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
        docRef.getDocument { document, error in
            if (error as NSError?) != nil {
            }
            else {
                if let document = document {
                    // fetch and assign to single variable first
                    var reviewFetch: [Review] = []
                    let data = document.data()
                    let reviews = data?["reviews"] as? [[String: Any]]
                    // fetch list of reviews of restaurant
                    for review in reviews ?? [] {
                        //https://stackoverflow.com/questions/42186398/swift-firebase-could-not-cast-value-of-type-nsdictionarym
                        let reviewDescription: String = review["reviewDescription"] as? String ?? ""
                        let timestamp: Timestamp = review["dateCreated"] as? Timestamp ?? Timestamp()
                        let dateCreated: Date = timestamp.dateValue()
                        let rating: Int = review["rating"] as? Int ?? 1
                        let email: String = review["email"] as? String ?? ""
                        let userId: String = review["userId"] as? String ?? ""
                        let isLiked: Bool = review["isLiked"] as? Bool ?? false
                        let newReview = Review(reviewDescription: reviewDescription, dateCreated: dateCreated, rating: rating, email: email, isLiked: isLiked, userId: userId)
                        reviewFetch.append(newReview)
                    }
                    
                    // assign to the reviews on local
                    model.currentRestaurant?.reviews = reviewFetch
                    //clear
                }
            }
        }
    }
    // MARK: get user avatar
    func getUserAvatar(userId: String, completion: @escaping (_ newAvatar: String) -> (), setUserName: @escaping (_ newUsername: String) -> ()) {
        let docRef = Firestore.firestore().collection("user").document(userId)
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    let avatarStr: String = data?["avatarStr"] as? String ?? ""
                    let name: String = data?["name"] as? String ?? ""
                    completion(avatarStr)
                    setUserName(name)
                }
            } }
    }
    
    // MARK: get user from firestore
    func getUserFirebase(id: String, userModel: UserModel, restaurantModel: RestaurantModel) {
        let docRef = Firestore.firestore().collection("user").document(id)
        //https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
        docRef.getDocument { document, error in
            if (error as NSError?) != nil {
            }
            else {
                if let document = document {
                    // fetch data object
                    let data = document.data()
                    
                    // assign fetched value to single element
                    let name: String = data?["name"] as? String ?? ""
                    let timestamp: Timestamp = data?["dob"] as? Timestamp ?? Timestamp()
                    let dob: Date = timestamp.dateValue()
                    let selectedGender: Int = data?["gender"] as? Int ?? 1
                    let email: String = data?["email"] as? String ?? ""
                    
                    // favorite
                    let restaurantsId = data?["favoriteRestaurants"] as? [String] ?? [String]()
                    let avatarStr: String = data?["avatarStr"] as? String ?? ""
                    var favouriteRestaurants = [Restaurant]()
                    for id in restaurantsId {
                        let rest = restaurantModel.findRestaurantById(id)
                        if let newRest = rest {
                            favouriteRestaurants.append(newRest)
                        }
                    }
                    // review
                    var savedReview = [Restaurant]()
                    let reviewsRestaurant: [String] = data?["reviewRestaurant"] as? [String] ?? [String]()
                    for id in reviewsRestaurant {
                        let rest = restaurantModel.findRestaurantById(id)
                        if let newRest = rest {
                            savedReview.append(newRest)
                        }
                    }

                    // dark mode save
                    let isDarkModeOn = data?["isDarkModeOn"] as? Bool ?? false

                    // create user object to store
                    let newUser = User(id: id, name: name, dob: dob, selectedGender: selectedGender, favouriteRestaurants: favouriteRestaurants, email: email, avatarStr: avatarStr, reviewRestaurant: savedReview, isDarkModeOn: isDarkModeOn)
                    // pass to user model
                    userModel.user = newUser
                }
            } }
    }

    // MARK: user favorite restaurants
    // remove
    func removeFavorites(user: User, restaurant: Restaurant) {
        Firestore.firestore().collection("user").document(user.id).updateData(["favoriteRestaurants": FieldValue.arrayRemove([restaurant.placeId!])]
        )
    }

    // change
    func changeFavorites(userModel: UserModel, restaurant: Restaurant, directRemove: Bool = false) -> Bool {
        // return false -> remove favorite
        // return true -> add favorite
        let restaurantIndex = userModel.isRestaurantFavorite(restaurant: restaurant)
        // if found in favorite list -> remove (the user click to unfavorite restaurant)
        if restaurantIndex != nil {
            userModel.user.favouriteRestaurants.remove(at: restaurantIndex!)
            removeFavorites(user: userModel.user, restaurant: restaurant)
            return false
        }
        // if not found in favorite list -> remove (the user click to add favorite restaurant)
        else {
            addToFavorites(user: userModel.user, restaurant: restaurant)
            userModel.user.favouriteRestaurants.append(restaurant)
            return true
        }
    }

    // add
    func addToFavorites(user: User, restaurant: Restaurant) {
        Firestore.firestore().collection("user").document(user.id).updateData(["favoriteRestaurants": FieldValue.arrayUnion([restaurant.placeId!])])
    }

    // MARK: dark light mode switch user
    func updateThemeMode(user: User) {
        Firestore.firestore().collection("user").document(user.id).updateData(["isDarkModeOn": user.isDarkModeOn])
    }
    
    // MARK: upload image to firestore
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // compress
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }

        // put data
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // error handling
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            // download
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
    
    // post image
    static func createPost(name: String, userModel: UserModel, for image: UIImage) {
        let imageRef = Storage.storage().reference().child("\(name).jpg")
        uploadImage(image, at: imageRef) { (downloadURL) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let downloadURL = downloadURL else {
                    return
                }

                let urlString = downloadURL.absoluteString
                userModel.user.avatarStr = urlString
            }
        }
//
    }
}
