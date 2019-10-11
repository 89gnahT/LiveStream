//
//  RTMP+AudioBasicDescription+Parameter.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import CoreMedia
extension CMAudioFormatDescription {
  
    var streamBasicDesc: AudioStreamBasicDescription? {
        get {
            return CMAudioFormatDescriptionGetStreamBasicDescription(self)?.pointee
        }
    }
}
