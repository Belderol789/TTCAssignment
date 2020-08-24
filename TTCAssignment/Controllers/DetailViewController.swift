//
//  DetailViewController.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/23/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController {
    // IBOutlets
    @IBOutlet weak var routeNameLabel: UILabel!
    @IBOutlet weak var stopTimeTable: UITableView!
    // Variables
    var selectedRoute: Route!
    var filteredStopTimes: [StopTime] = []
    // Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredStopTimes = selectedRoute.getStopTimes
        setupUI()
    }
    // MARK: - SetupUI
    fileprivate func setupUI() {
        routeNameLabel.text = selectedRoute.getName
        resultSearchController.searchResultsUpdater = self
        stopTimeTable.tableHeaderView = resultSearchController.searchBar
        // setup tableView
        stopTimeTable.register(StopTimeTableViewCell.nib, forCellReuseIdentifier: StopTimeTableViewCell.className)
        stopTimeTable.delegate = self
        stopTimeTable.dataSource = self
    }
}
// MARK: - UITableviewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStopTimes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let stopCell = tableView.dequeueReusableCell(withIdentifier: StopTimeTableViewCell.className, for: indexPath) as? StopTimeTableViewCell else { return UITableViewCell() }
        stopCell.setupCellFor(stopTime: filteredStopTimes[indexPath.row])
        return stopCell
    }
}
// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
// MARK: - SearchControllerDelegate
extension DetailViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let allStopTimes = selectedRoute.getStopTimes
        filteredStopTimes.removeAll(keepingCapacity: true)
        if let searchedText = searchController.searchBar.text, searchedText != "" {
            filteredStopTimes = allStopTimes.filter({$0.getShape.contains(searchedText)})
        } else {
            filteredStopTimes = allStopTimes
        }
        stopTimeTable.reloadData()
    }
}
