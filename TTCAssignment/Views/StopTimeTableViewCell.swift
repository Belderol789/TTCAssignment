//
//  StopTimeTableViewCell.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/23/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

class StopTimeTableViewCell: UITableViewCell, Reusable {
    // IBOutlets
    @IBOutlet weak var shapeLabel: UILabel!
    @IBOutlet weak var depatureTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    // Overiding functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // Implementing functions
    func setupCellFor(stopTime: StopTime) {
        shapeLabel.text = stopTime.getShape
        depatureTimeLabel.text = stopTime.getDepartureTime
        let stopTimeStatus = stopTime.getCurrentStatus()
        statusLabel.text = stopTimeStatus.0.rawValue
        timeLeftLabel.text = stopTimeStatus.1
        timeLeftLabel.adjustsFontSizeToFitWidth = true
    }
}
