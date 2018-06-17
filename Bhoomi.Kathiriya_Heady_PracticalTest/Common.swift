//
//  Common.swift
//  Collecting_Arts
//
//  Created by Bhumi kathiria on 23/05/18.
//  Copyright © 2018 Bhumi kathiria. All rights reserved.
//

import Foundation
import UIKit

let customOrangeColor = UIColor(red: 227.0/255.0, green: 119.0/255.0, blue: 30.0/255.0, alpha: 1.0)

//https://app.test.collecting-arts.net/login

//Dev Server

//let kBaseURL = "http://api.pluto/v1/apirouter"


//QA Server

let kBaseURL = "https://stark-spire-93433.herokuapp.com"


//Dev Server

//let kBaseMicorServieURL = "http://api.pluto/v1"


//QA Server

//let kBaseMicorServieURL = "https://api.test.collecting-arts.net/v1"


struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}




struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    
    static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_HEIGHT == 2436.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
}

extension UIScreen {
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5 = 1136.0
        case iPhone6 = 1334.0
        case iPhone6Plus = 1920.0
        case iPhoneX = 2436.0
    }
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}


enum DeviceTypeModel{
    case iphoneX
    case iphone8Plus
    case iphone8
    case iphoneSE //SE is the like iphone 5 and iphone 5s
    case iphone4s
    case unknown
}

extension UIViewController{
    func runOnTheDeviceType(_ completion: (DeviceTypeModel) -> Void) {
        if UIDevice().userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.height{
            case 2436:
                completion(.iphoneX)
            case 1920,2208:
                completion(.iphone8Plus)
            case 1334:
                completion(.iphone8)
            case 1136:
                completion(.iphoneSE)
            case 960:
                completion(.iphone4s)
            default:
                completion(.unknown)
            }
        }
    }
}
