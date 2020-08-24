//
//  Route.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

struct Route: Decodable {
    private let stop_times: [StopTime]
    private let route_group_id: String
    private let name: String
    private let uri: String
    
    enum CodingKeys: String, CodingKey {
        case stop_times
        case route_group_id
        case name
        case uri
    }
}

// MARK: - Route Getters
extension Route {
    var getStopTimes: [StopTime] {
        return stop_times
    }
    var getRouteGroupID: String {
        return route_group_id
    }
    var getName: String {
        return name
    }
    var getURI: String {
        return uri
    }
}

// MARK: - Route Protocols
extension Route {
    func filterStopTimes(serviceID: Int) -> StopTime? {
        guard let stopTime = getStopTimes.filter({$0.getServiceID == serviceID}).first else { return nil }
        return stopTime
    }
}
