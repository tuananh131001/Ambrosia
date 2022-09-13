//
//  ContentView.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 12/09/2022.
//

import Foundation
import SwiftUI

struct ContentView: View {
  @EnvironmentObject var authModel: AuthenticationModel
  @EnvironmentObject var restaurantModel: RestaurantModel

  
  var body: some View {
    switch authModel.state {
      case .signedIn: LaunchContentView()
      case .signedOut: LaunchContentView()
    }
  }
}
