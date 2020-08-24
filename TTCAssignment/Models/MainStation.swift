//
//  MainStation.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

struct MainStation: Decodable {
    private let time: Double
    private let stops: [Station]
    private let uri: String
    private let name: String
    enum CodingKeys: String, CodingKey {
        case time
        case stops
        case uri
        case name
    }
}

// MARK: - MainStation Getters
extension MainStation {
    var getStationName: String {
        return name
    }
    var getStationTime: Double {
        return time
    }
    var getDateFromTime: Date {
        return time.getDateFromTimeStamp()
    }
    var getDateString: String {
        return getDateFromTime.defaultDateString()
    }
    var getTimeString: String {
        return getDateFromTime.getDateString(format: "HH:mm")
    }
    var getAllStops: [Station] {
        return stops
    }
    var getDateAndTimeString: String {
        return "\(getDateString) - \(getTimeString)"
    }
}

// MARK: - MainStation Protocols
extension MainStation: Filterable {
    func filterObjects<T>(with key: String) -> T? {
        guard let station = getAllStops.filter({$0.getName == key}).first else { return nil }
        return station as? T
    }
}
