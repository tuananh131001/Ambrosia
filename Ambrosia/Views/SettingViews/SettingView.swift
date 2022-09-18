/*
    RMIT University Vietnam
    Course: COSC2659 iOS Development
    Semester: 2022B
    Assessment: Assignment 3
    Author: Tran Nguyen Ha Khanh, Vo Quoc Huy, Tran Mai Nhung
    ID: s3877707, s3823236, s3879954
    Created  date: 11/09/2022
    Last modified: 17/09/2022
    Acknowledgement:
    - Canvas
    - https://betterprogramming.pub/swiftui-app-theme-switch-241a79574b87
*/

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
    @State var isModalAppear = false
    @State var avatar : Image? = Image("default-avatar")
    @State var email : String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GeneralBackground()
                
                VStack {
                    VStack (spacing: 10) {
                        Spacer()
                        
                        ZStack (alignment: .bottomTrailing) {
                            AsyncImage(url: URL(string: userModel.user.avatarStr)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .modifier(CircularImageModifirer())

                            } placeholder: {
                                avatar?
                                    .resizable()
                                    .scaledToFill()
                                    .modifier(CircularImageModifirer())
                            }
                            
                            Button(action: {
                                SoundModel.clickOtherSound()
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
                                      Text(userModel.user.email)
                                  }
                                
                                  HStack {
                                    Text("Date of Birth")
                                    Spacer()
                                      Text(FormatDate.convertDateToString(formatDay: userModel.user.dob))
                                  }
                                
                                  HStack {
                                    Text("Gender")
                                    Spacer()
                                      Text(userModel.genders[userModel.user.selectedGender])
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
                                  ToggleTheme()
                                }
                            }
                        }
                        .font(.system(.body, design: .rounded))
                            
                        Spacer()
                        
                        VStack {
                            
                              // MARK: EDIT INFO BTN
                              Button {
                                  SoundModel.clickButtonSound()
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
                                  SoundModel.clickButtonSound()
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
                PickImageModal(showPickImageModal: $showPickImageModal, avatar: $avatar, isModalAppear: $isModalAppear)
                    .opacity(isModalAppear ? 1 : 0)
                    .offset(y: isModalAppear ? 0: geometry.frame(in: .global).maxY + 10)
                    .animation(.easeInOut(duration: Constants.ANIMATION_MODAL_DURATION), value: isModalAppear)
                    .onAppear() {
                        isModalAppear = true
                    }
            }
        }
        .onAppear(perform: {

        })
        .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
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
