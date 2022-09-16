//
//  SettingView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
// https://betterprogramming.pub/swiftui-app-theme-switch-241a79574b87
import SwiftUI
import Firebase

struct SettingView: View {
    @EnvironmentObject var userModel: UserModel
    @EnvironmentObject var restaurantModel: RestaurantModel
    @State var showEditInfo: Bool = false
    @State var showReviewList: Bool = false
    @State var showReview:Bool = false
    @State var hasAvatar: Bool = false
    @State var showPickImageModal = false
    @State var avatar : Image? = Image("default-avatar")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GeneralBackground()
                
                VStack {
                    VStack (spacing: 10) {
                        Spacer()
                        
                        ZStack {
                            ZStack (alignment: .bottomTrailing) {
                                Group {
    //                                if (userModel.user.avatarStr != "") {
    //                                    AsyncImage(url: URL(string: userModel.user.avatarStr)) { image in
    //                                        image.resizable()
    //                                        image.scaledToFill()
    //                                        image.modifier(AvatarModifier())
    //
    //                                    } placeholder: {
    //                                        Image("default-avatar")
    //                                    }
    //                                }
    //                                else {
                                        avatar?
                                            .resizable()
                                            .scaledToFill()
                                            .modifier(AvatarModifier())                            }
    //                            }
                                
                                Button(action: {
                                    showPickImageModal = true
                                }) {
                                  Image("camera-icon")
                                }
                                
                            }
                        }
                        

                        Text(userModel.user.name != "" ? userModel.user.name : "Ambrosa's Member")
                            .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE-15)! as CTFont))
                            .foregroundColor(.white)
                            .padding(.bottom, geometry.size.height*0.3*0.1)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height*0.3)
                
                    VStack (spacing: 10) {
                        Form {
                            Section(header:
                                      Text("Profile Information")
                                      .font(.system(size: 15))
                                      .fontWeight(.semibold)
                            ) {
                                  HStack {
                                    Text("Email")
                                    Spacer()
                                      Text((Auth.auth().currentUser?.email != "" ? Auth.auth().currentUser?.email : Auth.auth().currentUser?.providerData[0].email) ?? "")
                                  }
                                
                                  HStack {
                                    Text("Date of Birth")
                                    Spacer()
                                      Text(FormatDate.convertDateToString(formatDay: userModel.user.dob))
                                  }
                                
                                  HStack {
                                    Text("Gender")
                                    Spacer()
                                      Text(userModel.user.selectedGender == 0 ? "Male" : "Female")
                                  }
                            }
                            
                            Section(header:
                                      Text("Settings")
                                      .font(.system(size: 15))
                                      .fontWeight(.semibold)
                            ) {
                                HStack {
                                  Text("Appearance")
                                  Spacer()
                                    ToggleTheme()
                                }
                            }
                        }
                        .font(.system(.body, design: .rounded))
                            
                        Spacer()
                        
                        VStack {
                              // MARK: EDIT INFO BTN
                              Button {
                                  showEditInfo = true

                              } label: {
                                  HStack {
                                      Text("Edit Profile").bold()
                                      Image("edit-icon")
                                  }
                              }
                                  .buttonStyle(ButtonStylePrimary())

                              // MARK: SIGN OUT BTN
                              Button {
                                  // background music
                                  SoundModel.startBackgroundMusic(bckName: "login")
                                  // sound effect
                                  SoundModel.clickCardSound()
                                  userModel.SignOut()
                              } label: {
                                  HStack {
                                      Text("Sign Out").bold()
                                      Image("signout-icon")
                                  }
                                  
                              }
                                  .buttonStyle(ButtonStyleLightPrimary())
                            
                        }
                        .padding(.bottom, geometry.size.height*0.13)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height*0.7)
                    .background(Color("BackgroundSettingView"))
                Button {
                    showReview = true
                } label: {
                    Text("Recent Reivews").foregroundColor(Color("SecondaryColor")).font(.system(size: 14)).bold()
                }.sheet(isPresented: $showReview) {
                    RecentReviews()
                }
                }

            }
            
            if(showPickImageModal) {
                PickImageModal(showPickImageModal: $showPickImageModal, avatar: $avatar)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        .onAppear(perform: {
            if (userModel.user.avatarStr != "") {
                if let resourcePath = Bundle.main.resourcePath {
                    let imgName = "userAvatar.png"
                    let path = resourcePath + "/" + imgName
                    PickImageModal.download(url: URL(string: userModel.user.avatarStr)!, toFile: URL(string: path)!, completion: {_ in
                        print("download done")
                    })
                }
                avatar = Image("userAvatar")
            }
        })
        .sheet(isPresented: $showEditInfo) {
            EditInformation()
        }
        
            .sheet(isPresented: $showReviewList) {
            RecentReviews()
        }
            .onAppear(perform: {
                ThemeViewUtil.setAppTheme(userModel)
        })
    }
    
}
