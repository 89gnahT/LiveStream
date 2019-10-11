//
//  RTMPChunkEncoder.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
protocol ChunkEncoderProtocol {
    func chunkFrom(size: Int, firstType0: Bool) -> [Data]
}

protocol ChunkEncoderTypeProtocol {
    func encode() -> Data
}

struct ChunkEncoder {
    var chunkSize = UInt32(maxChunkSize)
    func chunk(message: RTMPBaseMessageProtocol & ChunkEncoderTypeProtocol, isFirstType0: Bool = true) -> [Data] {
        let payload =  message.encode()
        return payload
            .split(Int(chunkSize))
            .enumerated()
            .map({
                var data = Data()
                // basic Header
                // Type 0 == first chunk , other use type 3
                
                if $0.offset == 0 {
                    var messageH: MessageHeaderProtocol!
                    if isFirstType0 {
                        messageH = MessageHeaderType0(timestamp: message.timestamp,
                                                     msgLength: payload.count,
                                                     type: message.messageType ,
                                                     msgStreamId: message.msgStreamId)
                        
                    } else {
                        messageH = MessageHeaderType1(timestampDelta: message.timestamp,
                                                     msgLength: payload.count,
                                                     type: message.messageType)
                    }
                    let basic = RTMPChunkHeader(streamId: message.streamId,
                                                 messageHeader: messageH,
                                                 chunkPayload : Data($0.element))
                    data.append(basic.encode())
                } else {
                    let basic = RTMPChunkHeader(streamId: message.streamId,
                                                 messageHeader: MessageHeaderType3(),
                                                 chunkPayload: Data($0.element))
                    data.append(basic.encode())
                }
                return data
            })
    }
    
    mutating func reset() {
        chunkSize = UInt32(maxChunkSize)
    }
}
