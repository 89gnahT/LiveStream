//
//  UserControlMessage.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
class UserControlMessage: ControlMessage, ChunkEncoderTypeProtocol {
    let eventType: UserControlEventType
    let data: Data

    init(type: UserControlEventType, data: Data) {
        self.data = data
        self.eventType = type
        super.init(type: .control)
    }
    
    convenience init(streamBufferLength: Int, streamId: Int) {
        let id = UInt32(streamId).bigEndian.data
        let length = UInt32(streamBufferLength).bigEndian.data
        self.init(type: .streamBufferLength, data: id+length)
    }
    
    func encode() -> Data {
        var data = Data()
        data.extendWrite.write(UInt16(eventType.rawValue))
            .write(self.data)
        return data
    }
}
