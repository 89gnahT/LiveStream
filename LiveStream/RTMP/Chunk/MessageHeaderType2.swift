//
//  MessageHeaderType2.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
struct MessageHeaderType2: MessageHeaderType2Protocol {
    let timestampDelta: TimeInterval
    public init(timestampDelta: TimeInterval) {
        self.timestampDelta = timestampDelta
    }
    func encode() -> Data {
        var data = Data()
        data.extendWrite.writeU24(Int(timestampDelta))
        return data
    }
}
