//
//  Constant.swift
//  Ambrosia
//
//  Created by Khanh Tran Nguyen Ha on 10/09/2022.
//

import Foundation
import SwiftUI


enum Constants {
    static let PRIMARY_COLOR : Color = Color("PrimaryColor")
    static let PRIMARY_COLOR_UI : UIColor = UIColor(named: "PrimaryColor")!
    static let LIGH_PRIMARY_COLOR : Color = Color("LightPrimary")
    static let LIGH_PRIMARY_COLOR_UI : UIColor = UIColor(named: "LightPrimary")!
    static let BCK_COLOR: Color = Color("BackgroundViewColor")
    static let CARD_BCK_COLOR: Color = Color("CardBackgroundColor")
    
    static let APP_NAME_LARGE_SIZE : CGFloat = 45
    static let FORM_PADDING_VERTICAL : CGFloat = 30
    static let FORM_PADDING_HORIZAONTAL : CGFloat = 20
    static let MODAL_MIN_HEIGHT : CGFloat = 280
    static let MODAL_WIDTH : CGFloat = 300
    
    
    static let FIELD_PADDING : CGFloat = 10
    static let FIELD_HEIGHT: CGFloat = 44
    static let FIELD_MIN_WIDTH: CGFloat = 230
    static let FIELD_MAX_WIDTH: CGFloat = 320
    static let CONRNER_RADIUS: CGFloat = 10
    
    static let SPLASH_CIRCLE_OPACITY: CGFloat = 0.4
    static let SPLASH_ANIMATION_ARRAY: Int = 10
    
    static let DEFAULT_LOCATION_LAT = 10.729746193761306
    static let DEFAULT_LOCATION_LNG = 106.6930755973141
    
    static let DARK_MODE = "DARK_MODE"
    static let LIGHT_MODE = "LIGHT_MODE"
}
