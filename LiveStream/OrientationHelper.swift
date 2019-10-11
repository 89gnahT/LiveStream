//
//  OrientationHelper.swift
//  LiveStream
//
//  Created by CPU12015 on 10/11/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import UIKit

class OrientationHelper: NSObject {
    class public func getDeviceOrientation() -> UIDeviceOrientation{
        return UIDevice.current.orientation
    }
}
