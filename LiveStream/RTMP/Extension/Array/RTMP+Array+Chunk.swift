//
//  RTMP+Array+Chunk.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Array {
    func split(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map({
            let end = $0 + size >= count ? count : $0 + size
            return Array(self[$0..<end])
        })
    }
}
