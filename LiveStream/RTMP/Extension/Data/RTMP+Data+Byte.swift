//
//  RTMP+Data+Byte.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Data {
    public var bytes:[UInt8] {
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> [UInt8] in
//            let unsafeBufferPointer = buffer.bindMemory(to: [UInt8].self)
//            let unsafePointer = unsafeBufferPointer.baseAddress!
//            return [UInt8](UnsafeBufferPointer(start: unsafePointer.pointee, count: count))
//        })
        return withUnsafeBytes {
            return [UInt8](UnsafeBufferPointer(start: $0, count: count))
        }
    }
    
    public func split(_ size : Int) -> [Data] {
        return self.bytes.split(size: size).map({Data($0)})
    }
}

extension Data {
    var int : Int {
        return withUnsafeBytes{ $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> Int in
//            let unsafeBufferPointer = buffer.bindMemory(to: Int.self)
//            let unsafePointer : UnsafePointer<Int> = UnsafePointer<Int>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var uint8: UInt8 {
        return withUnsafeBytes { $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> UInt8 in
//            let unsafeBufferPointer = buffer.bindMemory(to: UInt8.self)
//            let unsafePointer : UnsafePointer<UInt8> = UnsafePointer<UInt8>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var uint16: UInt16 {
        return withUnsafeBytes { $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> UInt16 in
//            let unsafeBufferPointer = buffer.bindMemory(to: UInt16.self)
//            let unsafePointer : UnsafePointer<UInt16> = UnsafePointer<UInt16>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var int32: Int32 {
        return withUnsafeBytes { $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> Int32 in
//            let unsafeBufferPointer = buffer.bindMemory(to: Int32.self)
//            let unsafePointer : UnsafePointer<Int32> = UnsafePointer<Int32>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var uint32: UInt32 {
        return withUnsafeBytes { $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> UInt32 in
//            let unsafeBufferPointer = buffer.bindMemory(to: UInt32.self)
//            let unsafePointer : UnsafePointer<UInt32> = UnsafePointer<UInt32>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var float: Float {
        return withUnsafeBytes { $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> Float in
//            let unsafeBufferPointer = buffer.bindMemory(to: Float.self)
//            let unsafePointer : UnsafePointer<Float> = UnsafePointer<Float>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var double: Double {
        return withUnsafeBytes{ $0.pointee }
//        return withUnsafeBytes({(buffer : UnsafeRawBufferPointer) -> Double in
//            let unsafeBufferPointer = buffer.bindMemory(to: Double.self)
//            let unsafePointer : UnsafePointer<Double> = UnsafePointer<Double>.init(unsafeBufferPointer.baseAddress!)
//            return unsafePointer.pointee
//        })
    }
    
    var string: String {
        return String(data:self, encoding: .utf8) ?? ""
    }
}
