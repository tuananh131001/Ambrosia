//
//  InformationForm.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import SwiftUI
import Firebase

struct InformationForm: View {
    @EnvironmentObject var userModel: UserModel

    var body: some View {
        // MARK: LOGIN PAGE CONTENT
        ZStack {
            ZStack {
                // MARK: LOGIN INPUT FIELDS
                VStack (spacing: 20) {
                    
                    Text("Edit Profile")
                        .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                        .foregroundColor(Constants.PRIMARY_COLOR)
                  
                    VStack (spacing: 10) {
                        Group {
                            HStack {
                                Text("Email:").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                Spacer()
                                Text("\(Auth.auth().currentUser?.email ?? "hidden")")
                            }
                            .padding(.bottom, 10)
                            
                            
                            HStack {
                                Text("Name").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                Spacer()
                                TextField("Name", text: $userModel.user.name)
                                    .padding(.horizontal)
                                    .frame(maxWidth: 170, minHeight: Constants.FIELD_HEIGHT-6)
                                    .background(.thinMaterial)
                                    .cornerRadius(Constants.CONRNER_RADIUS)
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                            }
                            
                            DatePicker(selection: $userModel.user.dob, in: ...Date(), displayedComponents: .date) {
                                Text("Birthday").bold().foregroundColor(Constants.PRIMARY_COLOR)
                            }
                            
                            HStack (spacing: 10) {
                                Text("Gender").bold().foregroundColor(Constants.PRIMARY_COLOR)
                                
                                Picker("", selection: $userModel.user.selectedGender) {
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
                    .padding(.horizontal, Constants.FORM_PADDING_HORIZAONTAL)
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
struct InformationForm_Previews: PreviewProvider {
    static var previews: some View {
        InformationForm()
    }
}
