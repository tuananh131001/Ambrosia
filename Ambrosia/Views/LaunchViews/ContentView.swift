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
  @EnvironmentObject var model: RestaurantModel

  
  var body: some View {
    switch authModel.state {
      case .signedIn: HomeView(model: _model, viewModel: _authModel)
      case .signedOut: LaunchContentView()
    }
  }
}
