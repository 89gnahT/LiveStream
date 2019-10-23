//
//  RTMP+AMF0Protocol.swift
//  LiveStream
//
//  Created by CPU11899 on 10/9/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
let nullString = "Null"
enum DecodeSubType {
    case array(count : Int)
    case object(encodeKey : String)
    case ecma(encodeKey : String, count : Int)
    case none
}

protocol DecodeResponseProtocol {
    init(decode : Any?)
}

protocol AMF0KeyEncode {
    var amf0KeyEncode : Data {get}
}

protocol AMF0Encode {
    var amf0Encode : Data {get}
}
