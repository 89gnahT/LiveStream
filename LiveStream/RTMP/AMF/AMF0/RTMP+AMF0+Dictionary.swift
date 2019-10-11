//
//  RTMP+AMF0+Dictionary.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    var amf0Encode : Data {
        var data : Data = Data()
        data.extendWrite.write(RTMPAMF0Type.object.rawValue).write(self.keyValueEncode() + Data([0x00,0x00,RTMPAMF0Type.objectEnd.rawValue]))
        return data
    }
    
    var amf0EcmaArray : Data {
        var data : Data = Data()
        data.extendWrite.write(RTMPAMF0Type.array.rawValue).write(UInt32(self.count)).write(self.keyValueEncode())
        return data
    }
    
    fileprivate func keyValueEncode() -> Data {
        var data : Data = Data()
        self.forEach { (key, value) in
            let keyEncode = key.amf0KeyEncode
            data.append(keyEncode)
            if let valueEncode = (value as? AMF0Encode)?.amf0Encode {
                data.append(valueEncode)
            } else {
                data.extendWrite.write(RTMPAMF0Type.null.rawValue)
            }
        }
        return data
    }
}
