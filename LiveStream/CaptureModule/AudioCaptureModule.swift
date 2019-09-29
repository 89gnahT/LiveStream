//
//  AudioCaptureModule.swift
//  LiveStream
//
//  Created by Thang on 27/9/2019.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioCaptureModuleDelegate {
    func didCaptureAudioBuffer(_ audioBuffer: CMSampleBuffer)
}

class AudioCaptureModule: NSObject {
    
//MARK: Variables
    var audioDevice: AVCaptureDevice?
    
    var audioDeviceInput: AVCaptureDeviceInput?

    var audioQueue: DispatchQueue?
    var audioOutput: AVCaptureAudioDataOutput?
    var audioConnection: AVCaptureConnection?
    
    var audioDelegate: AudioCaptureModuleDelegate?
    
//MARK: Authorization
    func microphoneAuthorizationStatus() -> MicrophoneUsageStatus {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            return .MicrophoneUsageAllowed

        case .notDetermined:
            return .MicrophoneUsageNotDetermined

        case .denied:
            return .MicrophoneUsageDenied

        case .restricted:
            return .MicrophoneUsageRestricted

        @unknown default:
            print("Unknown microphone authorization error")
            return .MicrophoneUsageUnknown
        }
    }
    
    func requestMicrophoneAuthorization(completionHandler: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            completionHandler(granted)
        }
    }
    
//MARK: Setup methods
    func setupDevice() throws {
        self.audioDevice = AVCaptureDevice.default(.builtInMicrophone, for: .audio, position: .unspecified)
        if (self.audioDevice == nil) {
            throw AudioCaptureError.microphoneUnavailable
        }
    }
    
    func setupDeviceInput(captureSession: inout AVCaptureSession?) throws {
        guard let session = captureSession else {
            throw AVCaptureModule.AVCaptureError.sessionUnavailable
        }
        if let audioDevice = self.audioDevice {
            self.audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice)
            if session.canAddInput(self.audioDeviceInput!) {
                session.addInput(self.audioDeviceInput!)
            }
            else {
                throw AudioCaptureError.missingAudioInput
            }
        }
    }
    
    func setupDeviceOutput() {
        self.audioQueue = DispatchQueue(label: "Audio Capture Queue")
        
        self.audioOutput = AVCaptureAudioDataOutput()
        self.audioOutput!.setSampleBufferDelegate(self, queue: self.audioQueue)
        
        self.audioConnection = self.audioOutput!.connection(with: .audio)
    }
    
}

//MARK: AudioDataOutputSampleBufferDelegate
extension AudioCaptureModule: AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        audioDelegate?.didCaptureAudioBuffer(sampleBuffer)
    }
}


//MARK: enum
extension AudioCaptureModule {
    
    enum MicrophoneUsageStatus {
        case MicrophoneUsageAllowed
        case MicrophoneUsageNotDetermined
        case MicrophoneUsageDenied
        case MicrophoneUsageRestricted
        case MicrophoneUsageUnknown
    }

    enum AudioCaptureError: Error {
        case microphoneUnavailable
        case missingAudioInput
    }
}
