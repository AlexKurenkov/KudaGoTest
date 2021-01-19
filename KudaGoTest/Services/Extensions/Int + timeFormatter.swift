//
//  Int + timeFormatter.swift
//  KudaGoTest
//
//  Created by Александр on 13.01.2021.
//

import Foundation

extension Int {
    
    public func timeFormat() -> String {
        let h = self / 60
        let m = Int(Double(self).truncatingRemainder(dividingBy: 60.0))
        return "\(h)ч.\(m)мин."
    }
}
