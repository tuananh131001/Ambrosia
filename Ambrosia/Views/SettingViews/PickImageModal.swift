/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Tran Nguyen Ha Khanh
 ID: s3877707
 Created  date: 16/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

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
    @State var message : String = ""
    @State var showMessage : Bool = false
    
    // for animation
    @Binding var isModalAppear: Bool
    
    
    var body: some View {
        ZStack {
            // MARK: - Blur background when appear modal
            Color("Shadow")
                .edgesIgnoringSafeArea(.all)
            // MARK: - modal
            VStack {
                // MARK: select image
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
                .frame(height: 120)
                .onTapGesture {
                    showingImagePicker = true
                }
                
                // MARK: save button
                Button(action: {
                    save()
                }) {
                    Text("Save").bold()
                }
                .buttonStyle(ButtonStyleWhite())
                
                // MARK: show message if success
                if (showMessage) {
                    Text(message)
                        .foregroundColor(.white)
                }
                
            }
            .offset(y:12)
            .padding(.horizontal, 15)
            .frame(maxWidth: Constants.MODAL_WIDTH, minHeight: Constants.MODAL_MIN_HEIGHT)
            .background(Constants.PRIMARY_COLOR)
            .foregroundColor(.white)
            .cornerRadius(Constants.CONRNER_RADIUS)
            .overlay(
                // MARK: close button
                Button(action: {
                    SoundModel.clickOtherSound()
                    isModalAppear = false
                    // for animation
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.ANIMATION_MODAL_DURATION) {
                        showPickImageModal = false
                    }
                    
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
    
    // load image function
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        
    }
    
    // save function when click save
    func save() {
        if let img = inputImage {
            guard let inputImage = inputImage else { return }
            avatar = Image(uiImage: inputImage)
            FirebaseService.createPost(name: userModel.user.id, userModel: userModel, for: img)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                userModel.user.id = userId
                userModel.firebaseService.updateUser(user: userModel.user)
                message = "Avatar is updated successfully ✅"
                showMessage = true
            })
        }
        else {
            userModel.user.avatarStr = ""
            message = "Cannot update avatar"
            showMessage = true
        }
    }
}
