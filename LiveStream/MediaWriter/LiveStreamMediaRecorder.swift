//
//  LiveStreamMediaRecorder.swift
//  LiveStream
//
//  Created by CPU12015 on 10/7/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//
import UIKit
import AVFoundation

class LiveStreamMediaRecorder: MediaRecorder, CanvasMetalViewDelegate, MicrophoneCaptureDelegate{
    
    func startRecording(mediaType: MediaWriterFileType, videoCodecType: AVVideoCodecType, outputSize: CGSize, orientationDevice : UIDeviceOrientation) {
        var transformRotationDegreeAngle : Double = 0
        
        switch orientationDevice {
        case .portrait:
            transformRotationDegreeAngle = 90
        case .portraitUpsideDown:
            transformRotationDegreeAngle = -90
        case .landscapeRight:
            transformRotationDegreeAngle = 180
        case .landscapeLeft:
            transformRotationDegreeAngle = 0
        default:
            transformRotationDegreeAngle = 0
        }
        
        super.startRecording(mediaType: mediaType, videoCodecType: videoCodecType, outputSize: outputSize, transformRotationDegreeAngle: transformRotationDegreeAngle)
    }
    
    func didOutputPixelBuffer(_ pixelBuffer: CVPixelBuffer, _ presentationTimeStamp: CMTime, _ duration: CMTime, _ frameSize: CGSize) {
        super.didCapture(pixelBuffer: pixelBuffer, presentationTimeStamp: presentationTimeStamp, duration: duration)
    }
    
    func didCaptureAudioBuffer(_ audioBuffer: CMSampleBuffer) {
        super.didCaptureAudioSampleBuffer(sampleBuffer: audioBuffer)
    }
}
