//
//  RTMP+AMF3+Date.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Date: AMF3Encode {
    var amf3Encode: Data {
        let mileSecondSince1970 = Double(self.timeIntervalSince1970 * 1000)
        var data = Data()
        data.extendWrite.write(RTMPAMF3Type.date.rawValue)
            .write(AMF3EncodeType.U29.value.rawValue)
            .write(mileSecondSince1970)
        return data
    }
}
