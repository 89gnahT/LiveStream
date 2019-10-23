//
//  RTMP+AMF0+Bool.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation

extension Bool: AMF0Encode {
    var amf0Encode: Data {
        return Data([RTMPAMF0Type.boolean.rawValue, self ? 0x01 : 0x00])
    }
}
