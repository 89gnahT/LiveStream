//
//  RTMP+Dictionary+DecodeObject.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
extension Dictionary {
    
    func decodeObject<T: Decodable>() -> T? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let obj = try? JSONDecoder().decode(T.self, from: data) {
            return obj
        }
        return nil
    }
}
