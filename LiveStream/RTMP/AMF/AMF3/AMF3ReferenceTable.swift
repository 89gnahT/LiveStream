//
//  AMF3ReferenceTable.swift
//  LiveStream
//
//  Created by Huynh Lam Phu Si on 10/10/19.
//  Copyright © 2019 ThangNVH. All rights reserved.
//

import Foundation
public class AMF3ReferenceTable {
    private(set) lazy var string = {
        return [String]()
    }()
    private(set) lazy var objects = {
        return [Any]()
    }()
}

extension AMF3ReferenceTable {
    func append(_ value: String) {
        self.string.append(value)
    }
    
    func string(index: Int) -> String {
        return self.string[index]
    }
}

extension AMF3ReferenceTable {
    func createReserved() -> Int {
        self.objects.append([Any]())
        return self.objects.count - 1
    }
    
    func replace(_ value: Any, idx: Int) {
        self.objects[idx] = value
    }
    
    func append(_ value: Any) {
        self.objects.append(value)
    }
    
    func object<T>(_ index: Int) -> T? {
        return self.objects[index] as? T
    }
}
