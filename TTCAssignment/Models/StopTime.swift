//
//  Stop_Time.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation

enum StopStatus: String {
    case leavingSoon = "Leaving Soon"
    case left = "Already Left"
    case farAway = "Far away"
    case unavailable = "Unavailable"
}

struct StopTime: Decodable {
    private let departure_time: String
    private let shape: String
    private let departure_timestamp: Double
    private let service_id: Int
    enum CodingKeys: String, CodingKey {
        case departure_time
        case shape
        case departure_timestamp
        case service_id
    }
}

// MARK: - Route Getters
extension StopTime {
    var getDepartureTime: String {
        return departure_time
    }
    var getShape: String {
        return shape
    }
    var getDepartureTimeStamp: Double {
        return departure_timestamp
    }
    var getServiceID: Int {
        return service_id
    }
}
// MARK: - Functions
extension StopTime {
    func getCurrentStatus() -> (StopStatus, String) {
        let timeNow = Date()
        let stopTime = getStopDateTime()
        let timePassed = Calendar.current.dateComponents([.hour, .minute], from: timeNow, to: stopTime)
        let hours = timePassed.hour ?? 0
        let minutes = timePassed.minute ?? 0
        switch hours {
        case ..<0:
            return (.left, "\(minutes) minutes left")
        case 0...1:
            return (.leavingSoon, "\(minutes) minutes left")
        default:
            return (.farAway, "\(hours) hours left")
        }
    }
    fileprivate func getStopDateTime() -> Date {
        return Date(timeIntervalSince1970: departure_timestamp)
    }
}
