////
////  UserModel.swift
////  Ambrosia
////
////  Created by Võ Quốc Huy on 06/09/2022.
////
import Foundation

class UserModel:ObservableObject{
    @Published var loginSuccess = false
    @Published var isNewUser = false

    @Published var user:User = User(id: "", name: "", dob: Date(), selectedGender: 0)
    let genders = ["Male", "Female"]
}
