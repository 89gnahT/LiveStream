//
//  UIDeviceOrientation.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
extension UIDeviceOrientation {
    var avcaptureOrientation: AVCaptureVideoOrientation {
        get {
            switch self {
            case .landscapeLeft:
                return .landscapeRight
            case .landscapeRight:
                return .landscapeLeft
            case .portrait:
                return .portrait
            case .portraitUpsideDown:
                return .portraitUpsideDown
            default:
                return .portrait
            }
        }
    }
    
}
