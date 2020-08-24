//
//  DateExtension.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

extension Double {
    func getDateFromTimeStamp() -> Date {
        let date = Date(timeIntervalSince1970: self)
        return date
    }
}
