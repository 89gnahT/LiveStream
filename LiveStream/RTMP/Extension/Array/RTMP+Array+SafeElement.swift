//
//  RTMP+Array+SafeElement.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
public extension Array {
    subscript (safe range: CountableRange<Int>) -> ArraySlice<Element>? {
        
        if range.lowerBound < 0 || range.count > self.count {
            return nil
        }
        return self[range]
    }
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
