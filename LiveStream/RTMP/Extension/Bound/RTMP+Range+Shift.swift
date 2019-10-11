//
//  RTMP+Range+Shift.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension CountableClosedRange where Bound == Int {
    func shift(index: Int) -> CountableClosedRange<Int> {
        return self.lowerBound+index...self.upperBound+index
    }
}
extension CountableRange where Bound == Int {
    func shift(index: Int) -> CountableRange<Int> {
        return self.lowerBound+index..<self.upperBound+index
    }
}
