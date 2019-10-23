//
//  RTMP+AMF3+Bool.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Bool: AMF3Encode {
    var amf3Encode: Data {
        return Data([self == false ? 0x02 : 0x03])
    }
}
