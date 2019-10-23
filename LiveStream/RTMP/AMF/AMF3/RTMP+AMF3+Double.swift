//
//  RTMP+AMF3+Double.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Double: AMF3Encode {
    var amf3Encode: Data {
        var data = Data()
        data.extendWrite.write(RTMPAMF3Type.double.rawValue)
            .write(self)
        return data
    }
}

extension Double: AMF3VectorUnitEncode {
    var vectorData: Data {
        return Data(self.data.reversed())
    }
}
