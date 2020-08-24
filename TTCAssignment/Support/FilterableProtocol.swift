//
//  FilterableProtocol.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

protocol Filterable {
    func filterObjects<T>(with key: String) -> T?
}
