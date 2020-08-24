//
//  APIManager.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/21/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import Foundation
import Alamofire

typealias MainStationHandler = (_ mainStation: MainStation?) -> Void

final class APIManager {
    // MARK: - Variables
    private static let _instance = APIManager()
    static var Instance: APIManager {
        return _instance
    }
    private let apiURLString: String = "https://myttc.ca/finch_station.json"
    // MARK: - Functions
    func retrieveMainStation(_ mainStation: MainStationHandler?) {
        let afRequest = AF.request(apiURLString)
        afRequest.responseDecodable(of: MainStation.self) { (response) in
            mainStation?(response.value)
        }
    }
}
