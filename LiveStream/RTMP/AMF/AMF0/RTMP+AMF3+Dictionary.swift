//
//  RTMP+AMF3+Dictionary.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Dictionary where Key == String {
    var amf3Encode: Data {
        var data = Data()
        data.extendWrite.write([RTMPAMF3Type.object.rawValue, 0x0b, RTMPAMF3Type.null.rawValue])
        self.forEach { (key, value) in
            let keyEncode = key.amf3KeyEncode
            data.append(keyEncode)
            if let value = (value as? AMF3Encode)?.amf3Encode {
                data.append(value)
            } else {
                data.extendWrite.write(RTMPAMF3Type.null.rawValue)
            }
        }
        data.extendWrite.write(RTMPAMF3Type.null.rawValue)
        return data
    }
}
