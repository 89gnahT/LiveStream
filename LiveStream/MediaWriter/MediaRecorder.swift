//
//  MediaRecorder.swift
//  LiveStream
//
//  Created by CPU12015 on 10/3/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import UIKit
import AVFoundation
import  Photos

enum MediaRecorderStatus :Int{
    // Object is newly created and not yet recording
    case unknow
    
    // Object is recording
    case recording
    
    // Object has been running before and is now sopped but not completed
    case pausing
    
    // Stopped
    case stopped
}

class MediaRecorder: NSObject, CanvasMetalViewDelegate, MicrophoneCaptureDelegate  {
    var mediaWriter : MediaFileWriter?
    var status : MediaRecorderStatus = .unknow
    let recoderQueue = DispatchQueue(label: "recorder queue")
    override init() {
        super.init()
        status = .unknow
    }
    
    // Call this func to start recording video to save into Photos
    func startRecording(mediaType : MediaWriterFileType, videoCodecType: AVVideoCodecType, outputSize : CGSize){
        recoderQueue.async {
            if self.status == .unknow || self.status == .stopped{
                // Start recording
                self.status = .recording
                
                if #available(iOS 11.0, *) {
                    self.mediaWriter = MediaFIleWriterStore.CreateVideoWriter(mediaType: mediaType, videoCodecType: videoCodecType, outputSize: outputSize)
                } else {
                    // Fallback on earlier versions
                }
                if !(self.mediaWriter?.startWriting() ?? false){
                    print("MediaRecorder: Can't start recording")
                }else{
                    print("MediaRecorder: Recording")
                }
            }
        }
    }
    
    // Call this func (called startRecording before) to pause recording
    func pause(){
        recoderQueue.async {
            if self.status == .recording{
                self.status = .pausing
                
                print("MediaRecorder: pausing")
            }
        }
    }
    
    // Call this funtion to stop recording, video recoded is stored in Photos
    func stopRecording(completion : @escaping (URL) -> Void){
        recoderQueue.async {
            if self.status == .pausing || self.status == .recording{
                // Stop recording
                self.status = .stopped
                
                print("MediaRecorder: stopped")
                
                self.mediaWriter?.finishWriting(completion: { (url) in
                    // Copy into Photos
                    if url != nil{
                        completion(url!)
                        
                    }
                })
            }
        }
    }
    
    // MARK: Delegate
    func didOutputPixelBuffer(_ pixelBuffer: CVPixelBuffer, _ presentationTimeStamp: CMTime, _ duration: CMTime,_ frameSize: CGSize) {
        recoderQueue.async {
            if self.status != .recording {
                return
            }
            let sampleBuffer = self.createSampleBufferFrom(pixelBuffer: pixelBuffer, presentationTimestamp: presentationTimeStamp, duration: duration)
            if sampleBuffer != nil{
                self.videoAppend(sampleBuffer: sampleBuffer!)
            }
        }
    }
    
    func didCaptureAudioBuffer(_ audioBuffer: CMSampleBuffer) {
        recoderQueue.async {
            self.audioAppend(sampleBuffer: audioBuffer)
        }
    }
    
    // MARK: Helper
    
    private func videoAppend(sampleBuffer : CMSampleBuffer){
        if status == .recording{
            mediaWriter?.videoAppend(sampleBuffer: sampleBuffer)
        }
    }
    
    private func audioAppend(sampleBuffer : CMSampleBuffer){
        if status == .recording{
            mediaWriter?.audioAppend(sampleBuffer: sampleBuffer)
        }
    }
    
    
    
    private func createSampleBufferFrom(pixelBuffer : CVPixelBuffer, presentationTimestamp : CMTime, duration : CMTime) -> CMSampleBuffer?{
        var formatDesc: CMVideoFormatDescription?
        var sampleBuffer: CMSampleBuffer?
        //print("Height: ",CVPixelBufferGetHeight(pixelBuffer)," width: ",CVPixelBufferGetWidth(pixelBuffer))
        
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer, formatDescriptionOut: &formatDesc)
        
        if formatDesc != nil  {
            var sampleTiming = CMSampleTimingInfo.init(duration: duration, presentationTimeStamp: presentationTimestamp, decodeTimeStamp: CMTime.invalid)
            CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault,
                                                     imageBuffer: pixelBuffer,
                                                     formatDescription: formatDesc!,
                                                     sampleTiming: &sampleTiming,
                                                     sampleBufferOut: &sampleBuffer)
            
        }
        return sampleBuffer
    }
    
}
