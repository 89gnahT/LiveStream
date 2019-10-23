//
//  RTMP+AMF3+Array.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Array: AMF3Encode {
    var amf3Encode: Data {
        let encodeLength = (self.count << 1 | 0x01).amf3LengthConvert
        var data = Data()
        data.extendWrite.write(RTMPAMF3Type.array.rawValue)
        data.append(encodeLength)
        self.forEach {
            if let valueEncode = ($0 as? AMF3Encode)?.amf3Encode {
                data.append(valueEncode)
            }
        }
        return data
    }
}

extension Array: AMF3VectorEncode {
    var amf3VectorEncode: Data {
        var type: RTMPAMF3Type?
        if Element.self == UInt32.self {
            type = .vectorUInt
        } else if Element.self == Int32.self {
            type = .vectorInt
        } else if Element.self == Double.self {
            type = .vectorDouble
        } else {
            type = .vectorObject
        }
        guard let t = type else {
            return Data()
        }
        
        let encodeLength = (self.count << 1 | 0x01).amf3LengthConvert
        var data : Data = Data()
        data.extendWrite.write(t.rawValue).write(encodeLength).write(AMF3EncodeType.Vector.dynamic.rawValue)
        if type == .vectorObject {
            let objectType = "*".amf3Encode
            let encodeLength = (objectType.count << 1 | 0x01).amf3LengthConvert
            data.extendWrite.write(encodeLength).write(objectType)
            self.forEach ({
                if let encode = ($0 as? AMF3Encode)?.amf3Encode {
                    data.extendWrite.write(encode)
                }
            })
        } else {
            self.forEach {
                if let encode = ($0 as? AMF3VectorUnitEncode)?.vectorData {
                    data.extendWrite.write(encode)
                }
            }
        }
        return data
    }
}
