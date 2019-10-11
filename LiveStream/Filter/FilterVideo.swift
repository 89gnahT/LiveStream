//
//  FilterVideo.swift
//  LiveStream
//
//  Created by Thang Nguyen Vo Hong on 9/29/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import AVFoundation
import UIKit
import MobileCoreServices

protocol FilterVideoDelegate {
    func didCapturePixelBuffer(_ pixelBuffer: CVPixelBuffer, _ presentationTimeStamp: CMTime, _ duration: CMTime)
}

class FilterVideo: NSObject, CameraCaptureDelegate {
    
    var filterIndex: Int = 0
    var videoFilterOn: Bool = false
    var renderingEnable: Bool = true
    
    var previewDelegate: FilterVideoDelegate?
    
    private var videoFilter : FrameFilter?
    private var photoFilter : FrameFilter?
    
    private let FrameFilters: [FrameFilter] = [Lookup(),LowContract(),Luminance(), ColorInversion(), Purple()]
    private let photoRenderers: [FrameFilter] = [Lookup(),LowContract(),Luminance(), ColorInversion(), Purple()]
    
    private let photoOutput = AVCapturePhotoOutput()
    static var processingQueue = DispatchQueue(label: "photo processing queue", attributes: [], autoreleaseFrequency: .workItem)
    
    
    override init() {
        super.init()
        videoFilterOn = true
        self.videoFilterOnOff()
    }
    
    private class func jpegData(withPixelBuffer pixelBuffer: CVPixelBuffer, attachments: CFDictionary?) -> Data? {
        let ciContext = CIContext()
        let renderedCIImage = CIImage(cvImageBuffer: pixelBuffer)
        guard let renderedCGImage = ciContext.createCGImage(renderedCIImage, from: renderedCIImage.extent) else {
            print("Failed to create CGImage")
            return nil
        }
        
        guard let data = CFDataCreateMutable(kCFAllocatorDefault, 0) else {
            print("Create CFData error!")
            return nil
        }
        
        guard let cgImageDestination = CGImageDestinationCreateWithData(data, kUTTypeJPEG, 1, nil) else {
            print("Create CGImageDestination error!")
            return nil
        }
        
        CGImageDestinationAddImage(cgImageDestination, renderedCGImage, attachments)
        if CGImageDestinationFinalize(cgImageDestination) {
            return data as Data
        }
        print("Finalizing CGImageDestination error!")
        return nil
    }
    
    func didCaptureCameraBuffer(_ sampleBuffer: CMSampleBuffer) {
        guard let videoPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer),
                let formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer) else {
                    return
            }
            
            var finalVideoPixelBuffer = videoPixelBuffer
        if videoFilterOn {
            if let filter = videoFilter {
                if !filter.isPrepared {
                    /*
                     outputRetainedBufferCountHint is the number of pixel buffers the renderer retains. This value informs the renderer
                     how to size its buffer pool and how many pixel buffers to preallocate. Allow 3 frames of latency to cover the dispatch_async call.
                     */
                    filter.prepare(with: formatDescription, outputRetainedBufferCountHint: 3)
                    print("filter is prepare")
                }
                
                // Send the pixel buffer through the filter
                guard let filteredBuffer = filter.render(pixelBuffer: finalVideoPixelBuffer) else {
                    print("Unable to filter video buffer")
                    return
                }

                finalVideoPixelBuffer = filteredBuffer
            }
        }
        //print("Presentation time anh time stamp : \(CMSampleBufferGetDecodeTimeStamp(sampleBuffer))  and  \(CMSampleBufferGetDuration(sampleBuffer))")
        self.previewDelegate?.didCapturePixelBuffer(finalVideoPixelBuffer, CMSampleBufferGetPresentationTimeStamp(sampleBuffer), CMSampleBufferGetDuration(sampleBuffer))
    }
    
    
   
    
    
    func videoFilterOnOff(){
        
        //videoFilterOn = !videoFilterOn
        let filteringEnabled = videoFilterOn
        
        let index = filterIndex
        
        
        
        // Enable/disable the video filter.
        CameraCapture.cameraCaptureQueue.async {
            if filteringEnabled {
                self.videoFilter = self.FrameFilters[index]
            } else {
                if let filter = self.videoFilter {
                    filter.reset()
                }
                self.videoFilter = nil
            }
        }
        
        // Enable/disable the photo filter.
        FilterVideo.processingQueue.async {
            if filteringEnabled {
                self.photoFilter = self.photoRenderers[index]
            } else {
                if let filter = self.photoFilter {
                    filter.reset()
                }
                self.photoFilter = nil
            }
        }
        
    }
    
    
    func switchCamera(){
           CameraCapture.cameraCaptureQueue.async {
               if let filter = self.videoFilter {
                   filter.reset()
               }
           }
           
           FilterVideo.processingQueue.async {
               if let filter = self.photoFilter {
                   filter.reset()
               }
           }
    }
    func changeFilter(_ gesture: UISwipeGestureRecognizer){
        let filteringEnabled = videoFilterOn
        if filteringEnabled {
            if gesture.direction == .left {
                filterIndex = (filterIndex + 1) % FrameFilters.count
            } else if gesture.direction == .right {
                filterIndex = (filterIndex + FrameFilters.count - 1) % FrameFilters.count
            } else if gesture.direction == .up {
                videoFilterOn = !videoFilterOn
                print("video Filter : \(videoFilterOn)")
                self.videoFilterOnOff()
            }
            else if gesture.direction == .down {
                videoFilterOn = !videoFilterOn
                print("video Filter : \(videoFilterOn)")
                self.videoFilterOnOff()
            }
            
            let newIndex = filterIndex
            
            // Switch renderers
            CameraCapture.cameraCaptureQueue.async {
                if let filter = self.videoFilter {
                    filter.reset()
                }
                self.videoFilter = self.FrameFilters[newIndex]
            }
            
            FilterVideo.processingQueue.async {
                if let filter = self.photoFilter {
                    filter.reset()
                }
                self.photoFilter = self.photoRenderers[newIndex]
            }
        }
    }
    
    
}


