//
//  RTMPPublish.swift
//  LiveStream
//
//  Created by CPU11899 on 10/8/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

public class RTMPPublishLayer: AVCaptureVideoPreviewLayer {
    
    var capture = AVCaptureModule()
    fileprivate var statusCallBack: ((RTMPPublishSession.Status)->Void?)?
    public var publishSession =  RTMPPublishSession()
    
    public var videoFPS: TimeInterval {
        get {
            guard let videoInput = AVCaptureDevice.default(for: .video) else {
                return 30
            }
            return TimeInterval(videoInput.activeVideoMinFrameDuration.timescale)
        } set {
            guard let videoInput = AVCaptureDevice.default(for: .video) else {
                return
            }
            let fps = CMTime(value: 1, timescale: CMTimeScale(newValue))
            try? videoInput.lockForConfiguration()
            videoInput.activeVideoMinFrameDuration = fps
            videoInput.activeVideoMaxFrameDuration = fps
            videoInput.unlockForConfiguration()
        }
    }
    
    public var currentStatus: RTMPPublishSession.Status {
        get {
            return publishSession.publishStatus
        }
    }

    fileprivate lazy var videoOutput: AVCaptureVideoDataOutput = {
        return AVCaptureVideoDataOutput()
    }()
    fileprivate lazy var audioOutput: AVCaptureAudioDataOutput = {
        return AVCaptureAudioDataOutput()
    }()
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
 
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public override init() {
        super.init(session: AVCaptureSession())
    }
    
    public override init(session: AVCaptureSession) {
        super.init(session: session)
    }
}
// Public
extension RTMPPublishLayer {
    public func setMessageType(type: ObjectEncodingType) {
        publishSession.encodeType = type
    }

    public func publishStatus(callBack: ((RTMPPublishSession.Status)->Void)?) {
        statusCallBack = callBack
    }
    
    public func publish(host: String, name: String, port:Int = defaultPort) {
        publishSession.publishStream(host: host, port: port, name: name).resume()
    }
    
    public func stop() {
        publishSession.invalidate()
    }
}
// Private
extension RTMPPublishLayer {
    fileprivate func setup() {
        if session?.outputs.contains(videoOutput) == true && session?.outputs.contains(audioOutput) == true {
            return
        }
        publishSession.delegate = self
        guard let audioInput = AVCaptureDevice.default(for: .audio) else {
            return
        }
        guard let videoInput = AVCaptureDevice.default(for: .video) else {
            return
        }
        do {
            try self.session?.addInput(AVCaptureDeviceInput(device: videoInput))
            try self.session?.addInput(AVCaptureDeviceInput(device: audioInput))
        } catch {
            return
        }
        self.videoFPS = 30
    }
}
extension RTMPPublishLayer: MicrophoneCaptureDelegate {
    func didCaptureAudioBuffer(_ audioBuffer: CMSampleBuffer) {
        self.publishSession.publishAudio(buffer: audioBuffer)
    }
}

extension RTMPPublishLayer: CanvasMetalViewDelegate {
    func didOutputPixelBuffer(_ pixelBuffer: CVPixelBuffer, _ presentationTimeStamp: CMTime, _ duration: CMTime, _ frameSize : CGSize) {
        
        var formatDesc: CMVideoFormatDescription?
        var sampleBuffer: CMSampleBuffer?
        
        CMVideoFormatDescriptionCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer, formatDescriptionOut: &formatDesc)
        
        if formatDesc != nil  {
            var sampleTiming = CMSampleTimingInfo.init(duration: duration, presentationTimeStamp: presentationTimeStamp, decodeTimeStamp: CMTime.invalid)
            CMSampleBufferCreateReadyWithImageBuffer(allocator: kCFAllocatorDefault,
                                                     imageBuffer: pixelBuffer,
                                                     formatDescription: formatDesc!,
                                                     sampleTiming: &sampleTiming,
                                                     sampleBufferOut: &sampleBuffer)
        }
        self.publishSession.setVideoSizeIfNeed(frameSize)
        self.publishSession.publishVideo(buffer: sampleBuffer!)
    }
}
    

extension RTMPPublishLayer: RTMPPublishSessionDelegate {
    public func sessionMetaData(_ session: RTMPPublishSession) -> [String : Any] {
        var meta = [String: Any]()
        meta["width"] = Int32(self.bounds.width)
        meta["height"] = Int32(self.bounds.height)
        meta["displayWidth"] = Int32(self.bounds.width)
        meta["displayHeight"] = Int32(self.bounds.height)
        meta["videocodecid"] = VideoData.CodecId.avc.rawValue
        meta["audiocodecid"] = AudioData.SoundFormat.aac.rawValue
        meta["framerate"] = videoFPS
        meta["videoframerate"] = videoFPS
        return meta
    }
    
    public func sessionStatusChange(_ session: RTMPPublishSession,  status: RTMPPublishSession.Status) {
        DispatchQueue.main.async { [weak self] in
            self?.statusCallBack?(status)
        }
    }
}
