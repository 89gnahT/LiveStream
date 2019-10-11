//
//  RTMP+AMF0+UInt.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension UInt : AMF0Encode {
    var amf0Encode : Data {
        return Double(self).amf0Encode
    }
}

extension UInt8 : AMF0Encode {
    var amf0Encode : Data {
        return Double(self).amf0Encode
    }
}

extension UInt16 : AMF0Encode {
    var amf0Encode : Data {
        return Double(self).amf0Encode
    }
}

extension UInt32 : AMF0Encode {
    var amf0Encode : Data {
        return Double(self).amf0Encode
    }
}
