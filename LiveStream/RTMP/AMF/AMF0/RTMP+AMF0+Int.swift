//
//  RTMP+AMF0+Int.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation

extension Int: AMF0Encode {
    var amf0Encode: Data {
        return Double(self).amf0Encode
    }
}

extension Int8: AMF0Encode {
    var amf0Encode: Data {
        return Double(self).amf0Encode
    }
}

extension Int32: AMF0Encode {
    var amf0Encode: Data {
        return Double(self).amf0Encode
    }
}
