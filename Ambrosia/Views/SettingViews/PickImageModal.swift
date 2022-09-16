//
//  PickImageModal.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 16/09/2022.
//

import SwiftUI

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
                .frame(height: 180)
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
            print(userModel.user.avatarStr)
            userModel.firebaseService.updateUser(user: userModel.user)

            if let resourcePath = Bundle.main.resourcePath {
                let imgName = "userAvatar.png"
                let path = resourcePath + "/" + imgName
                PickImageModal.download(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/ambrosia-4e8fb.appspot.com/o/yjg9zIHztqdFtuvnsGcMl1zmxh93.jpg?alt=media&token=92274cc1-9a34-42e7-bf5a-f436dd858c6a")!, toFile: URL(string: path)!, completion: {_ in
                    print("download done")
                })
            }
        }
        else {
            userModel.user.avatarStr = ""
        }
    }
    
    static func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            // Handle potential file system errors
            catch let fileError {
                completion(error)
            }
        }

        // Start the download
        task.resume()
    }
}
