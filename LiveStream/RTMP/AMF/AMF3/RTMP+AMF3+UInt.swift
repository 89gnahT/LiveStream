//
//  RTMP+AMF3+UInt.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension UInt8: AMF3Encode {
    var amf3Encode: Data {
        return Int(self).amf3Encode
    }
}

extension UInt16: AMF3Encode {
    var amf3Encode: Data {
        return Int(self).amf3Encode
    }
}

extension UInt32: AMF3Encode {
    var amf3Encode: Data {
        return Int(self).amf3Encode
    }
}

extension UInt32: AMF3VectorUnitEncode {
    var vectorData: Data {
        return self.bigEndian.data
    }
}
