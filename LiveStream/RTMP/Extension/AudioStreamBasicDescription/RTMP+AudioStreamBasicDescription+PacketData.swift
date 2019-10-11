//
//  RTMP+AudioStreamBasicDescription+PacketData.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AudioToolbox
extension AudioStreamBasicDescription {
    var packetPerSecond: Int {
        get {
            return Int(Float(self.mSampleRate)/Float(self.mFramesPerPacket))
        }
    }
}
