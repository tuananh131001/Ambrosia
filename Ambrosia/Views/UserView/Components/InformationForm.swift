//
//  InformationForm.swift
//  Ambrosia
//
//  Created by William on 12/09/2022.
//

import SwiftUI
import Firebase

struct InformationForm: View {
    @EnvironmentObject var userModel: AuthenticationModel
    private var services = FirebaseService.services

    var body: some View {
        // MARK: LOGIN PAGE CONTENT
        ZStack {
            ZStack {
                // MARK: LOGIN INPUT FIELDS
                VStack (spacing: 20) {
                    Group {
                        Text("Edit Information")
                            .font(Font(UIFont(name: "Chalkboard SE Bold", size: Constants.APP_NAME_LARGE_SIZE)! as CTFont))
                    }
                    VStack (spacing: 10) {
                        Group {
                            Text("Email: \(Auth.auth().currentUser?.email ?? "Error")")
                            TextField("Name", text: $userModel.user.name)
                                .modifier(TextFieldModifier())
                            DatePicker(selection: $userModel.user.dob, in: ...Date(), displayedComponents: .date) {
                                Text("Birthday")
                            }
                            HStack {
                                Text("Gender")
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
                    .foregroundColor(Constants.PRIMARY_COLOR)
            }
                .background(.white)
                .frame(minWidth: Constants.FIELD_MIN_WIDTH, maxWidth: Constants.FIELD_MAX_WIDTH)
                .foregroundColor(.white)
                .cornerRadius(Constants.CONRNER_RADIUS)
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
