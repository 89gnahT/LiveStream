//
//  RTMP+AMF3+Data.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Data: AMF3ByteArrayEncode {
    var byteEncode: Data {
        let encodeLength = (self.count << 1 | 0x01).amf3LengthConvert
        var data = Data()
        data.extendWrite.write(RTMPAMF3Type.byteArray.rawValue)
        data += (encodeLength+self)
        return data
    }
}
