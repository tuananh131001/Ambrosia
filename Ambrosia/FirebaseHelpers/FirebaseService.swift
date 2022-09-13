//
//  FirebaseService.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
// https://stackoverflow.com/questions/60225869/how-do-i-return-an-object-from-a-document-stored-in-firestore-swift

import Foundation
import Firebase
import FirebaseFirestoreSwift
class FirebaseService: ObservableObject {
    static let services = FirebaseService()
    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false
    @Published var user: User?

    var users: [User] = [User]()

    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String, user: UserModel) {
        if (email == "" || password == "" || passwordConfirmation == "") {
            self.signUpMessage = "Please fill in all the fields"
        }
        else if (passwordConfirmation != password) {
            self.signUpMessage = "Confirm password doesn't match"
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
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
                    self.signUpMessage = "Sign up successfully"
                    guard let userID = authResult?.user.uid else { return }
                    Firestore.firestore().collection("user").document(userID).setData([
                        "name": "Sir",
                        "email": authResult?.user.email ?? ""
                        ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    user.loginSuccess = true
                    user.isNewUser = true
                    self.signUpSuccess = true

                }
            }
        }
    }
    func updateUser(user: User) {
        Firestore.firestore().collection("user").document(user.id).setData(["name": user.name, "dob": user.dob, "gender": user.selectedGender, "favouriteRestaurants": [String]()], merge: true)
    }

    func addToFavorites(user: User, restaurant: Restaurant) {
        Firestore.firestore().collection("user").document(user.id).updateData(["favoriteRestaurants": FieldValue.arrayUnion([restaurant.place_id])]
        )
    }
    func removeFavorites(user: User, restaurant: Restaurant ) {
        Firestore.firestore().collection("user").document(user.id).updateData(["favoriteRestaurants": FieldValue.arrayRemove([restaurant.place_id])]
        )
    }
    
    func changeFavorites(userModel: UserModel, restaurant: Restaurant) -> Bool {
        // return true -> remove favorite
        // return false -> add favorite
        let restaurantIndex = userModel.isRestaurantFavorite(restaurant: restaurant)
        if restaurantIndex != nil {
            userModel.user.favouriteRestaurants.remove(at: restaurantIndex!)
            removeFavorites(user: userModel.user, restaurant: restaurant)
            return true
        }
        else {
            addToFavorites(user: userModel.user, restaurant: restaurant)
            userModel.user.favouriteRestaurants.append(restaurant)
            return false
        }
    }

    func fetchUser(uid: String, restaurantModel: RestaurantModel, completion: @escaping((User?) -> ())) {

        Firestore.firestore().collection("user").document(uid).getDocument { (snapshot, error) in
            if let error = error {
                print("Failed to fetch current user:", error)
                return
            }
            guard let data = snapshot?.data() else { return }
            let name = data["name"] as? String ?? ""
            let dob = data["dob"] as? Date ?? Date()
            let selectedGender = data["selectedGender"] as? Int ?? 0
            let restaurantsId = data["favouriteRestaurants"] as? [String] ?? [String]()
            var favouriteRestaurants = [Restaurant]()
            for id in restaurantsId {
                let rest = restaurantModel.findRestaurantById(id)
                if let newRest = rest {
                    favouriteRestaurants.append(newRest)
                }
            }

            let newUser = User(id: uid, name: name, dob: dob, selectedGender: selectedGender, favouriteRestaurants: favouriteRestaurants)
            completion(newUser)
        }


    }
}
