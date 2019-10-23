//
//  MessageHeaderType1.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
struct MessageHeaderType1: MessageHeaderType1Protocol {
    let timestampDelta: TimeInterval
    let msgLength: Int
    let type: MessageType
    
    public init(timestampDelta: TimeInterval, msgLength: Int, type: MessageType) {
        self.timestampDelta = timestampDelta
        self.msgLength = msgLength
        self.type = type
    }

    func encode() -> Data {
        var data = Data()
        data.extendWrite.writeU24(Int(timestampDelta))
            .writeU24(msgLength)
            .write(UInt8(type.rawValue))
        return data
    }
}
