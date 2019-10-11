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
    
    func didOutputPixelBuffer(_ pixelBuffer: CVPixelBuffer, _ presentationTimeStamp: CMTime, _ duration: CMTime) {
        super.didCapture(pixelBuffer: pixelBuffer, presentationTimeStamp: presentationTimeStamp, duration: duration)
    }
    
    func didCaptureAudioBuffer(_ audioBuffer: CMSampleBuffer) {
        super.didCaptureAudioSampleBuffer(sampleBuffer: audioBuffer)
    }
}
