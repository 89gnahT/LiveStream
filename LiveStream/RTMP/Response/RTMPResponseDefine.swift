//
//  RTMPResponseDefine.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
enum CodeType {
    enum Call: String {
        case badVersion = "NetConnection.Call.BadVersion"
        case failed     = "NetConnection.Call.Failed"
    }
    
    enum Connect: String, Decodable {
        case failed         = "NetConnection.Connect.Failed"
        case timeout        = "NetConnection.Connect.IdleTimeOut"
        case invalidApp     = "NetConnection.Connect.InvalidApp"
        case networkChange  = "NetConnection.Connect.NetworkChange"
        case reject         = "NetConnection.Connect.Rejected"
        case success        = "NetConnection.Connect.Success"
    }
}
