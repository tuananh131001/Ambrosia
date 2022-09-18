/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Nguyen Tuan Anh, Tran Nguyen Ha Khanh
 ID: s3864077, s3877707
 Created  date: 14/09/2022
 Last modified: 17/09/2022
 Acknowledgement:
 - Canvas
 */

import SwiftUI
import Firebase

struct InformationForm: View {
    @EnvironmentObject var userModel: UserModel
    @Binding var tempName : String
    @Binding var tempDob : Date
    @Binding var tempGender : Int
    
    var body: some View {
        // MARK: LOGIN PAGE CONTENT
        ZStack {
            ZStack {
                // MARK: - LOGIN INPUT FIELDS
                VStack (spacing: 20) {
                    // MARK: Title Of View
                    Text("Edit Profile")
                        .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                        .foregroundColor(Constants.PRIMARY_COLOR)
                    
                    VStack (spacing: 10) {
                        Group {
                            // MARK: display user email
                            HStack {
                                Text("Email:").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                Spacer()
                                Text(userModel.user.email)
                            }
                            .padding(.bottom, 10)
                            
                            // MARK: input user name
                            HStack {
                                // Label
                                Text("Name").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                Spacer()
                                // Input
                                TextField("Name", text: $tempName)
                                    .padding(.horizontal)
                                    .frame(maxWidth: 170, minHeight: Constants.FIELD_HEIGHT-6)
                                    .background(.thinMaterial)
                                    .cornerRadius(Constants.CONRNER_RADIUS)
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                            }
                            
                            // MARK: birthday
                            DatePicker(selection: $tempDob, in: ...Date(), displayedComponents: .date) {
                                Text("Birthday").bold().foregroundColor(Constants.PRIMARY_COLOR)
                            }
                            
                            // MARK: gender
                            HStack (spacing: 10) {
                                Text("Gender").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                
                                Picker("", selection: $tempGender) {
                                    ForEach(0..<userModel.genders.count, id: \.self) { index in
                                        Text(userModel.genders[index]).tag(index).font(.title)
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        .multilineTextAlignment(.leading)
                    }
                    
                    
                }
                .padding(.vertical, Constants.FORM_PADDING_VERTICAL + 10)
                .padding(.horizontal, Constants.FORM_PADDING_HORIZAONTAL-5)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("TextColor"))
            }
            .background((Color("ButtonTextColor")))
            .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)                .cornerRadius(Constants.CONRNER_RADIUS)
            .shadow(color: Color("Shadow"), radius: 6.0, x: 2, y: 2)
        }
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        
    }
}
