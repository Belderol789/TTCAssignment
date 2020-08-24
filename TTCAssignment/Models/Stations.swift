//
//  Stations.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

struct Station: Decodable {
    private var routes: [Route]
    private let name: String
    private let uri: String
    private let agency: String
    enum CodingKeys: String, CodingKey {
        case routes
        case name
        case uri
        case agency
    }
}

// MARK: - Station Getters
extension Station {
    var getRoutes: [Route] {
        return routes
    }
    var getName: String {
        return name
    }
    var getURI: String {
        return uri
    }
    var getAgency: String {
        return agency
    }
}

// MARK: - Station Protocols
extension Station: Filterable {
    func filterObjects<T>(with key: String) -> T? {
        guard let route = getRoutes.filter({$0.getName == key}).first else { return nil }
        return route as? T
    }
}
