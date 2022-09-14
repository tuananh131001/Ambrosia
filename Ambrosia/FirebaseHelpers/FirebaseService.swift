//
//  FirebaseService.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import GoogleSignIn


var provider: OAuthProvider?
var authMicrosoft: Auth?


class FirebaseService: ObservableObject {
    static let services = FirebaseService()
    
    @Published var showSignUpMessage = false
    @Published var signUpMessage = ""
    @Published var signUpSuccess = false
    
    @Published var user: User = User(id: "", name: "", dob: Date(), selectedGender: 0)
    let genders = ["Male", "Female"]
    
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    enum SignInMethod {
        case normal
        case google
        case phone
        case microsoft
    }

    @Published var state: SignInState = .signedOut
    @Published var loginSuccess: Bool = false
    @Published var isNewUser: Bool = false
    @Published var loginMethod: SignInMethod = .normal
    @Published var loginMessage = ""


    
    
    // Sign up function to use Firebase to create a new user account in Firebase
    func signUp(email: String, password: String, passwordConfirmation: String, user:FirebaseService)  {
    func signUp(email: String, password: String, passwordConfirmation: String, user: AuthenticationModel) {
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
    func updateUser(user: User) {
        Firestore.firestore().collection("user").document(user.id).setData(["name": user.name, "dob": user.dob, "gender": user.selectedGender], merge: true)
    }
    func addReviewToFirebase(restaurant: RestaurantDetail) {
        Firestore.firestore().collection("restaurant").document(restaurant.place_id ?? "").setData([ "created": true ], merge: true)
        var newReviewList: [[String: Any]] = []
        // get each reviews put in dictionary for uploading
        for riviu in restaurant.reviews {
            let newReview = ["reviewDescription": riviu.reviewDescription, "dateCreated": riviu.dateCreated, "rating": riviu.rating, "username": riviu.username, "email": riviu.email, "image": riviu.image, "isLiked": riviu.isLiked] as [String: Any]
            newReviewList.append(newReview)
        }
        // assign new data to firestore
        Firestore.firestore().collection("restaurant").document(restaurant.place_id ?? "").updateData([
            "reviews": newReviewList
        ])
    }
    func fetchReviewFromFirebase(restaurant: RestaurantDetail, model: RestaurantModel) {
        let docRef = Firestore.firestore().collection("restaurant").document(restaurant.place_id ?? "")
        //https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    var reviewFetch: [Review] = []
                    let data = document.data()
                    let reviews = data?["reviews"] as? [[String: Any]]
                    for review in reviews ?? [] {
                        //https://stackoverflow.com/questions/42186398/swift-firebase-could-not-cast-value-of-type-nsdictionarym
                        let reviewDescription: String = review["reviewDescription"] as? String ?? ""
                        let timestamp: Timestamp = review["dateCreated"] as? Timestamp ?? Timestamp()
                        let dateCreated: Date = timestamp.dateValue()
                        let rating: Int = review["rating"] as? Int ?? 1
                        let username: String = review["username"] as? String ?? ""
                        let email: String = review["email"] as? String ?? ""
                        let image: String = review["image"] as? String ?? ""
                        let isLiked: Bool = review["isLiked"] as? Bool ?? false
                        let newReview = Review(reviewDescription: reviewDescription, dateCreated: dateCreated, rating: rating, username: username, email: email, image: image, isLiked: isLiked)
                        reviewFetch.append(newReview)
                    }
                    // assign to the reviews on local
                    model.currentRestaurantDetail?.reviews = reviewFetch
                    //clear
                }
            }
        }

    
    
    
//    func NormalSignIn(email: String, password: String) {
//        if (email == "" || password == "") {
//            self.loginMessage = "Please enter email and password"
//            self.loginSuccess = false
//        }
//        else {
//            Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
//                if error != nil {
//                    let err = error?.localizedDescription ?? ""
//                    print(err)
//                    if (err.contains("no user record")) {
//                        self.loginMessage = "This email hasn't register yet"
//                    }
//                    else {
//                        self.loginMessage = "Invalid sign-in credentials"
//                    }
//                    self.loginSuccess = false
//                } else {
//                    print("success")
//                    self.loginMessage = "successfully"
//                    self.loginSuccess = true
//                }
//            }
//        }
//    }
    
    func MicrosoftSignIn() {
        provider = OAuthProvider(providerID: "microsoft.com")
        provider?.customParameters = [
          "prompt": "consent",
          "login_hint": ""
        ]
         
        provider?.getCredentialWith(nil) { credential, error in
          if error != nil {
              print(error?.localizedDescription ?? "FAILED GET CREDENTAIL MICROSOFT")
          }
            
          
            if let x = credential {
                Auth.auth().signIn(with: x) { authResult, error in
                    if error != nil {
                        self.loginSuccess = false
                        print(error?.localizedDescription ?? "FAILED LOGIN MICROSOFT")
                    }
                    else {
                        print("login success")
                        self.loginSuccess = true
                        self.loginMessage = "Login successfully. Redirecting..."
                        self.loginMethod = .microsoft
                        self.state = .signedIn
                    }

                }
            } else {
                print("FAILED GET CREDENTAIL MICROSOFT")
            }
        }
        
    }
    
    func GoogleSignIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let configuration = GIDConfiguration(clientID: clientID)

            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                GGAuthenticateUser(for: user, with: error)
            }
        }
    }

    private func GGAuthenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            loginSuccess = false
            print(error.localizedDescription)
            return
        }

        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            loginSuccess = false
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                loginSuccess = false
                print(error.localizedDescription)
            } else {
                loginSuccess = true
                loginMethod = .google
                self.loginMessage = "Login successfully. Redirecting..."
                self.state = .signedIn
            }
        }
    }

    
    func SignOut() {
        if (loginMethod == .google) {
            GIDSignIn.sharedInstance.signOut()
        }
        do {
            
              try Auth.auth().signOut()
              loginSuccess = false
              state = .signedOut
        } catch {
          print(error.localizedDescription)
        }
    }
    func getUserFirebase(id:String,authModel:AuthenticationModel){
        let docRef = Firestore.firestore().collection("user").document(id )
        //https://stackoverflow.com/questions/55368369/how-to-get-an-array-of-objects-from-firestore-in-swift
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
            }
            else {
                if let document = document {
                    let data = document.data()
                    let id: String = data?["id"]  as? String ?? ""
                    let name: String = data?["name"] as? String ?? ""
                    let timestamp: Timestamp = data?["dob"] as? Timestamp ?? Timestamp()
                    let dob: Date = timestamp.dateValue()
                    let selectedGender:Int = data?["selectedGender"]  as? Int ?? 1
                    let email:String = data?["email"]  as? String ?? ""
                    let newUser = User(id: id, name: name, dob: dob, selectedGender: selectedGender, email: email)
                    authModel.user = newUser
                }
            }
        }
    }
}
