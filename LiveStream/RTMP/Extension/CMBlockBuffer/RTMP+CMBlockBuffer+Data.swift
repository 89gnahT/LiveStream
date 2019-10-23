//
//  RTMP+CMBlockBuffer+Data.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import VideoToolbox
extension CMBlockBuffer {
    
    var data: Data? {
        
        var length: Int = 0
        var pointer: UnsafeMutablePointer<Int8>?
        
        guard CMBlockBufferGetDataPointer(self, atOffset: 0, lengthAtOffsetOut: nil, totalLengthOut: &length, dataPointerOut: &pointer) == noErr,
              let p = pointer else {
            return nil
        }
        return Data(bytes: p, count: length)
    }
    
    var length: Int {
        
        return CMBlockBufferGetDataLength(self)
    }

}
