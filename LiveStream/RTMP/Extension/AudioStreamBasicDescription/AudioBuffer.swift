//
//  AudioBuffer.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AudioToolbox
public struct AudioBuffer {
    let data: Data
    let desc: AudioStreamPacketDescription
    let timestamp: Int64
}


public struct AudioHeader {
    var desc: AudioStreamBasicDescription
    var startTime: Int64
}
