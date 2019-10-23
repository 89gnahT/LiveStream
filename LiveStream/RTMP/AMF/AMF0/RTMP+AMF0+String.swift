//
//  RTMP+AMF0+String.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension String: AMF0Encode, AMF0KeyEncode {
    
    var amf0Encode: Data {
        let isLong = UInt32(UInt16.max) < UInt32(self.count)
        let type : RTMPAMF0Type = isLong ? .longString : .string
        var data : Data = Data()
        data.extendWrite.write(type.rawValue).write(self.amf0KeyEncode)
        return data
    }
    
    var amf0KeyEncode: Data {
        let isLong = UInt32(UInt16.max) < UInt32(self.count)
        var data: Data = Data()
        let convert = Data(self.utf8)
        if isLong {
            data.extendWrite.write(UInt32(convert.count))
        } else {
            data.extendWrite.write(UInt16(convert.count))
        }
        data.extendWrite.writeUTF8(self)
        return data
    }
}
