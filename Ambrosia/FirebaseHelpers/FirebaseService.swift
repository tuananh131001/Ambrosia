//
//  FirebaseService.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
class FirebaseService: ObservableObject {
    static let services = FirebaseService()
    @Published var reviewFetch:[Review] = [Review(reviewDescription: "hơi siu", dateCreated: Date.now, rating: 5, username: "The King", email: "TheKing@gmail.com",image: "avatar4")]
    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false
    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String,user:AuthenticationModel)  {
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
    func updateUser(user:User ) {
        Firestore.firestore().collection("user").document(user.id).setData(["name": user.name, "dob": user.dob, "gender": user.selectedGender], merge: true)
    }
    func addReviewToFirebase(restaurant:RestaurantDetail ){
        for riviu in restaurant.reviews {
            Firestore.firestore().collection("restaurant").document(restaurant.place_id ?? "").updateData([
                "reviews": FieldValue.arrayUnion([["reviewDescription": riviu.reviewDescription, "dateCreated": riviu.dateCreated, "rating": riviu.rating, "username": riviu.username, "email": riviu.email,"image": riviu.image,"isLiked": riviu.isLiked]])
            ])
        }
    }
    func fetchReviewFromFirebase(restaurant:RestaurantDetail,model:RestaurantModel){
        let docRef = Firestore.firestore().collection("restaurant").document(restaurant.place_id ?? "")
        //https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
        
        docRef.getDocument { document, error in
            print("review")
            print(document!.get("reviews"))
            guard error == nil, let document = document, document.exists, let reviews = document.get("reviews") as? [Review] else { return }
            print("has decode review")
            print(reviews)

            
//            for review in reviews{
//                let newReview = Review(id: review.id, reviewDescription: review.reviewDescription, dateCreated: review.dateCreated, rating: review.rating, username: review.username, email: review.email, image: review.image, isLiked: review.isLiked)
//            }
          }
        
    }
}
