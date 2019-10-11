//
//  AMF0Object.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation

struct AMF0Object : AMF0Protocol {
    var data = Data()
    
    mutating func append(_ value : Double) {
        data.extendWrite.write(value.amf0Encode)
    }
    
    mutating func append(_ value : String) {
        data.extendWrite.write(value.amf0Encode)
    }
    
    mutating func append(_ value : Bool) {
        data.extendWrite.write(value.amf0Encode)
    }
    
    mutating func append(_ value : [String : Any?]?) {
        if let v = value {
            data.extendWrite.write(v.amf0Encode)
        }
    }
    
    mutating func append(_ value : Date) {
        data.extendWrite.write(value.amf0Encode)
    }
    
    mutating func appendNil() {
        data.extendWrite.write(RTMPAMF0Type.null.rawValue)
    }
    
    mutating func append(_ value: [Any]) {
        data.extendWrite.write(value.amf0Encode)
    }
    
    mutating func append(_ value: [String : Any?]) {
        data.extendWrite.write(value.amf0EcmaArray)
    }
    
    mutating func appendXML(_ value: String) {
        //data.extendWrite.write(value)
    }
    
    mutating func appendEcma(_ value: [String : Any?]) {
        data.extendWrite.write(value.amf0EcmaArray)
    }
    
    mutating func decode() -> [Any]? {
        return self.data.decodeAMF0()
    }
    
    static func decode(_ data: Data) -> [Any]? {
        return data.decodeAMF0()
    }
}
