//
//  ContentView.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import Foundation
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var userModel: UserModel
  @EnvironmentObject var model: RestaurantModel

  
  var body: some View {
    switch userModel.state {
      case .signedIn: LaunchContentView()
      case .signedOut: LaunchContentView()
    }
  }
}
