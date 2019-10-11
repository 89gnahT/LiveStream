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
    }
    
    var uint8: UInt8 {
        return withUnsafeBytes { $0.pointee }
    }
    
    var uint16: UInt16 {
        return withUnsafeBytes { $0.pointee }
    }
    
    var int32: Int32 {
        return withUnsafeBytes { $0.pointee }
    }
    
    var uint32: UInt32 {
        return withUnsafeBytes { $0.pointee }
    }
    
    var float: Float {
        return withUnsafeBytes { $0.pointee }
    }
    
    var double: Double {
        return withUnsafeBytes{ $0.pointee }
    }
    
    var string: String {
        return String(data:self, encoding: .utf8) ?? ""
    }
}
