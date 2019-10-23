//
//  RTMP+AMF0+Date.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Date : AMF0Encode {
    var amf0Encode: Data {
        let miliSecondSince1970 = Double(self.timeIntervalSince1970 * 1000)
        var data : Data = Data()
        data.extendWrite.write(RTMPAMF0Type.date.rawValue).write(miliSecondSince1970).write([UInt8]([0x0,0x0]))
        return data
    }
}
