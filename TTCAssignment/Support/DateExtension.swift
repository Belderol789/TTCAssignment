//
//  DateExtension.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

extension Date {
    func defaultDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    func getDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}
