////
////  UserModel.swift
////  Ambrosia
////
////  Created by Võ Quốc Huy on 06/09/2022.
////
//import Firebase
//import Foundation
//
//class UserModel:ObservableObject{
//    @Published var users:[User] = [User]()
//    @Published var currentUser:User?
//    init(){
//
//    }
//
//    func fetchAllUsers() {
//        let db = Firestore.firestore()
//
//        db.collection("users").getDocuments() { (querySnapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID): \(document.data())")
//                }
//            }
//        }
//    }
//    // Function to add restaurant to list of favorie restaurent for user
//    func addToFavorites(restaurant:Restaurant,email:String) {
//        let index = users.firstIndex { User in
//            User.email == email
//        }
//        currentUser = users[index ?? 0];
//        currentUser?.favoriteRestaurants.append(restaurant)
//    }
//
//
//}
