//
//  String.swift
//  RESTRx
//
//  Created by Ievgen Keba on 2/3/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation

extension String {
    
    func removeSpace () -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
