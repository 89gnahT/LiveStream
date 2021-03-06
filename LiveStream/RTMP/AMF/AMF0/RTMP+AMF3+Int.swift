//
//  RTMP+AMF3+Int.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Int: AMF3Encode {
    var amf3Encode: Data {
        var data = Data()
        data.extendWrite.write(RTMPAMF3Type.int.rawValue)
        data.append(self.amf3LengthConvert)
        return data
    }
}

extension Int: AMF3LengthEncode {
    var amf3LengthConvert: Data {
        switch self {
        case 0...0x7f:
            return Data([UInt8(self)])
        case 0x80...0x3fff:
            let first = UInt8(self >> 7 | 0x80)
            let second = UInt8(self & 0x7f)
            return Data([first, second])
        case 0x00004000...0x001fffff:
            let first = UInt8((self >> 14 & 0x7f) | 0x80)
            let second = UInt8((self >> 7 & 0x7f) | 0x80)
            let third = UInt8(self & 0x7f)
            return Data([first, second, third])
        case 0x00200000...0x1ffffff:
            let first = UInt8((self >> 22 & 0x7f) | 0x80)
            let second = UInt8((self >> 15 & 0x7f) | 0x80)
            let third = UInt8((self >> 8 & 0x7f) | 0x80)
            let fourth = UInt8(self & 0xff)
            return Data([first, second, third, fourth])
        default:
            return Double(self).amf3Encode
        }
    }
}

extension Int32: AMF3VectorUnitEncode {
    var vectorData: Data {
        return self.bigEndian.data
    }
}
