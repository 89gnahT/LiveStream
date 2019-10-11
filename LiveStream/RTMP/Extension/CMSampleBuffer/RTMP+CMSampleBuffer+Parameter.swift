//
//  RTMP+CMSampleBuffer+Parameter.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AVFoundation
import VideoToolbox
extension CMSampleBuffer {
    var presentedTimestamp: CMTime {
        get {
            return CMSampleBufferGetPresentationTimeStamp(self)
        }
    }
    
    var duration: CMTime {
        get {
            return CMSampleBufferGetDuration(self)
        }
    }
    
    var frameTimeRangeDuration: ClosedRange<Double> {
        get {
            let present = self.presentedTimestamp.seconds
            return present...(present+self.duration.seconds)
        }
        
    }
    
    var isKeyFrame: Bool {
        get {
            guard let attachments = CMSampleBufferGetSampleAttachmentsArray(self, createIfNecessary: false),
            let info = unsafeBitCast(CFArrayGetValueAtIndex(attachments, 0), to: CFDictionary.self) as? [AnyHashable : AnyObject],
                let rc = info["DependsOnOthers"] as? Bool, !rc else {
                    return false
            }
            return true
        }
    }
}
