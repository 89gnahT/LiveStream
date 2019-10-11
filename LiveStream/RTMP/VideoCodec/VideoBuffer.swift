//
//  VideoBuffer.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import VideoToolbox
public struct VideoBuffer {
    public let buffer: CMSampleBuffer
    public let timeStamp: Int64
    
    func isAudioContain(audioTime: CMTime) -> Bool {
        return buffer.frameTimeRangeDuration.contains(audioTime.seconds)
    }
}

public struct VideoHeader {
    public let desc: CMVideoFormatDescription
    public let startTime: Int64
}
