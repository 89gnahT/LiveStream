//
//  AMF3Object.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
struct AMF3Object: AMF3Protocol {
    var data: Data = Data()
    mutating func appendUndefined() {
        data.extendWrite.write(RTMPAMF3Type.undefined.rawValue)
    }
    
    mutating func appendNil() {
        data.extendWrite.write(RTMPAMF3Type.null.rawValue)
    }
    
    mutating func append(_ value : Bool) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: Int) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: Double) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: String) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func appendXML(_ value:String) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: Date) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: [Any]) {
        data.extendWrite.write(value.amf3Encode)
    }
    
    mutating func append(_ value: [String : Any?]?) {
        if let v = value {
            data.extendWrite.write(v.amf3Encode)
        }
    }
    
    mutating func appendVector(_ value: [Int32]) {
        data.extendWrite.write(value.amf3VectorEncode)
    }
    
    mutating func appendVector(_ value: [UInt32]) {
        data.extendWrite.write(value.amf3VectorEncode)
    }
    
    mutating func appendVector(_ value: [Double]) {
        data.extendWrite.write(value.amf3VectorEncode)
    }
    
    mutating func appendByteArray(_ value: Data) {
        data.extendWrite.write(value.byteEncode)
    }
    
    public func decode() -> [Any]? {
        return self.data.decodeAMF3()
    }
    
    public static func decode(_ data: Data) -> [Any]? {
        return data.decodeAMF3()
    }
}
