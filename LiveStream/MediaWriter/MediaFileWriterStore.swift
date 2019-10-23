//
//  MediaFIleWriterManager.swift
//  RecordCamera
//
//  Created by CPU12015 on 10/2/19.
//  Copyright © 2019 CPU12015. All rights reserved.
//
import UIKit
import AVFoundation


class MediaFIleWriterStore: NSObject {
    class func CreateVideoWriter(mediaType : MediaWriterFileType, videoCodecType: AVVideoCodecType, outputSize : CGSize, transformRotationDegreeAngle : Double = 0) -> MediaFileWriter?{
        var videoWriter : MediaFileWriter?
        
        if mediaType == .MP4 || mediaType == .M4V{
            videoWriter = MediaFileWriter(fileType: mediaType)
            _ = videoWriter?.createNewDefaultAudioInput()
            _ = videoWriter?.createNewVideoInput(videoCodecType: videoCodecType, outputSize: outputSize, transformRotationDegreeAngle: transformRotationDegreeAngle)
        }
        
        return videoWriter!
    }
   
}
