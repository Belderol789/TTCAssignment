//
//  ReusableProtocol.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/24/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var className: String { get }
    static var nib: UINib { get }
}

extension Reusable {
    static var className: String {
        return "\(self)"
    }
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}
