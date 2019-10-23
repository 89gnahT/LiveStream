//
//  TimeInterval+Convert.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension TimeInterval {
    var millSecond: TimeInterval {
        get {
            return self*1000
        }
    }
}
