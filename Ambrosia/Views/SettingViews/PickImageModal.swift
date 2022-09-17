//
//  PickImageModal.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 16/09/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseDatabase

struct PickImageModal: View {
    @EnvironmentObject var userModel: UserModel
    
    @Binding var showPickImageModal: Bool
    @Binding var avatar : Image?
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var image : Image?
    @State private var filterIntensity = 0.5
    
    
    var body: some View {
        ZStack {
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select image")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .frame(height: 140)
                .onTapGesture {
                    showingImagePicker = true
                }
                
                Button("Save", action: save)
                    .buttonStyle(ButtonStyleWhite())
                
            }
            .padding(15)
            .frame(maxWidth: Constants.MODAL_WIDTH, minHeight: Constants.MODAL_MIN_HEIGHT)
            .background(Constants.PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .overlay(
              Button(action: {
                  showPickImageModal = false
              }) {
                Image(systemName: "xmark.circle")
                  .font(.title)
              }
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.trailing, 20),
                alignment: .topTrailing
                )
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
    }
    
    func save() {
        if let img = inputImage {
            guard let inputImage = inputImage else { return }
            avatar = Image(uiImage: inputImage)
            FirebaseService.createPost(name: userModel.user.id, userModel: userModel, for: img)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                userModel.user.id = userId
                userModel.firebaseService.updateUser(user: userModel.user)
            })
        }
        else {
            userModel.user.avatarStr = ""
        }
    }
}
