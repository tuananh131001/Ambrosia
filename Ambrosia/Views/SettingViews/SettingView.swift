//
//  SettingView.swift
//  Ambrosia
//
//  Created by Võ Quốc Huy on 11/09/2022.
//
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
    

    // for dark light mode
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    // MARK: set theme dark light mode
    func setAppTheme() {
        //MARK: use saved device theme from toggle
        userModel.user.isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: userModel.user.isDarkModeOn)
        //MARK: or use device theme
        if (colorScheme == .dark)
        {
            userModel.user.isDarkModeOn = true
        }
        else {
            userModel.user.isDarkModeOn = false
        }
        changeDarkMode(state: userModel.user.isDarkModeOn)
    }
    func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as?
            UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
    var ToggleTheme: some View {
        Toggle("Dark Mode", isOn: $userModel.user.isDarkModeOn)
            .tint(Constants.PRIMARY_COLOR)
            .onChange(of: userModel.user.isDarkModeOn) { (state) in
            changeDarkMode(state: state)
            userModel.updateUserThemeMode()
        }.labelsHidden()
    }

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GeneralBackground()
                
                VStack {
                    VStack (spacing: 10) {
                        Spacer()
                        
                        ZStack (alignment: .bottomTrailing) {
                            Group {
                                if (userModel.user.avatarStr != "") {
                                    AsyncImage(url: URL(string: userModel.user.avatarStr)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .modifier(CircularImageModifirer())

                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                else {
                                    avatar?
                                        .resizable()
                                        .scaledToFill()
                                        .modifier(CircularImageModifirer())
                                }
                            }

                            Button(action: {
                                showPickImageModal = true
                            }) {
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 35, height: 35)
                                    
                                    Image("camera-icon")
                                          .resizable()
                                          .scaledToFill()
                                          .frame(width: 30, height: 30)
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
                                    Text("App Setting")
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                            )
                            {
                                HStack {
                                  Text("Dark Mode")
                                  Spacer()
                                  ToggleTheme
                                }
                            }
                        }
                        .font(.system(.body, design: .rounded))
                            
                        Spacer()
                        
                        VStack {
                            
                              // MARK: EDIT INFO BTN
                              Button {
                                    showReview = true

                              } label: {
                                  HStack {
                                      Text("View My Reviews").bold()
                                      Image("review-icon")
                                  }
                              }
                              .buttonStyle(ButtonStylePrimary())
                              .sheet(isPresented: $showReview) {
                                    RecentReviews()
                              }
                            
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

                }

            }
            
            if(showPickImageModal) {
                PickImageModal(showPickImageModal: $showPickImageModal, avatar: $avatar)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
        .sheet(isPresented: $showEditInfo) {
            EditInformation()
        }
        
            .sheet(isPresented: $showReviewList) {
            RecentReviews()
        }
            .onAppear(perform: {
            setAppTheme()
        })
    }
}
