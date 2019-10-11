//
//  BaseMessage.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
import UIKit
public class RTMPBaseMessage: RTMPBaseMessageProtocol {
    let messageType: MessageType
    var msgStreamId: Int
    let streamId: Int
    
    init(type: MessageType, msgStreamId: Int = 0, streamId: Int) {
        self.messageType = type
        self.msgStreamId = msgStreamId
        self.streamId = streamId
    }

    private var _timeInterval: TimeInterval = 0
    public var timestamp:TimeInterval  {
        set {
            _timeInterval = newValue >= maxTimestamp ? maxTimestamp : newValue
        } get {
            return _timeInterval
        }
    }
}
