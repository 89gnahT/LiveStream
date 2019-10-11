//
//  RTMP+AMF0+Double.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Float: AMF0Encode {
    var amf0Encode: Data {
        return Double(self).amf0Encode
    }
}

extension Double: AMF0Encode {
    var amf0Encode: Data {
        var data: Data = Data()
        data.extendWrite.write(RTMPAMF0Type.number.rawValue).write(self)
        return data
    }
}
