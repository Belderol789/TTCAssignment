//
//  InitialViewController.swift
//  TTCAssignment
//
//  Created by Kem Belderol on 8/22/20.
//  Copyright © 2020 Krats. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {
    // IBOutlets
    @IBOutlet weak var mainStationTable: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var mapImageView: UIImageView!
    // Constraints
    @IBOutlet weak var containerWidthConst: NSLayoutConstraint!
    // Variables
    fileprivate let finchWebsiteURL = "http://www.ttc.ca/Contact_Us/index.jsp"
    private let stationCellID: String = "StationCell"
    private var mainStation: MainStation?
    var filteredStops: [Station] = []
    // Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAPIData()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.scrollView.contentSize.width = self.view.frame.width * 2
            self.containerWidthConst.constant = self.view.frame.width * 2
            self.mapImageView.layoutIfNeeded()
        }
    }
    // MARK: - Get API
    fileprivate func getAPIData() {
        APIManager.Instance.retrieveMainStation { [unowned self] (mainStation) in
            self.mainStation = mainStation
            self.filteredStops = mainStation?.getAllStops ?? []
            DispatchQueue.main.async {
                if let mainStation = mainStation {
                    self.loadingView.stopAnimating()
                    self.mainStationTable.reloadData()
                    self.title = "\(mainStation.getStationName) - \(mainStation.getDateString)"
                } else {
                    self.showAlert(title: "Ooops", message: "Seems you have an network error", actions: [UIAlertAction(title: "Ok", style: .cancel, handler: nil),
                                                                                                         UIAlertAction(title: "Retry", style: .default, handler: { [weak self] _ in
                                                                                                            self?.getAPIData()
                                                                                                         })])
                }
            }
        }
    }
    // MARK: - SetupUI
    fileprivate func setupUI() {
        loadingView.hidesWhenStopped = true
        loadingView.startAnimating()
        // setup Tableview
        mainStationTable.register(UITableViewCell.self, forCellReuseIdentifier: stationCellID)
        mainStationTable.delegate = self
        mainStationTable.dataSource = self
        // setup navigationController
        title = "Finch Station - \(Date().defaultDateString())"
        let largeTitleAppearance = UINavigationBarAppearance()
        largeTitleAppearance.backgroundImage = R.image.finchBackdrop()
        largeTitleAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = largeTitleAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = largeTitleAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        // setup searchController
        resultSearchController.searchResultsUpdater = self
        mainStationTable.tableHeaderView = resultSearchController.searchBar
        // setup ScrollView
        scrollView.contentSize.width = view.frame.width * 2
        containerWidthConst.constant = view.frame.width * 2
    }
    // MARK: - IBActions
    @IBAction func didSelectSegmentedControl(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0 ? scrollView.scrollToPreviousItem() : scrollView.scrollToNextItem()
    }
    @IBAction func contactUsBtnTapped(_ sender: UIButton) {
        guard let finchURL = URL(string: finchWebsiteURL) else { return }
        if UIApplication.shared.canOpenURL(finchURL) {
            UIApplication.shared.open(finchURL, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - UITableViewDataSource
extension InitialViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let stopsCount = filteredStops.count
        return stopsCount
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitle = filteredStops[section].getName
        return sectionTitle
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let routeCount = filteredStops[section].getRoutes.count
        return routeCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: stationCellID)
        let route = filteredStops[indexPath.section].getRoutes[indexPath.row]
        cell.textLabel?.text = route.getName
        cell.detailTextLabel?.text = "\(route.getStopTimes.count) stops"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRoute = filteredStops[indexPath.section].getRoutes[indexPath.row]
        print("Selected Route name \(selectedRoute.getName)")
        guard let detailVC = R.storyboard.main.detailViewController() else { return }
        detailVC.selectedRoute = selectedRoute
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - UITableViewDelegate
extension InitialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
// MARK: - SearchControllerDelegate
extension InitialViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let allStops = mainStation?.getAllStops else { return }
        filteredStops.removeAll(keepingCapacity: true)
        if let searchedText = searchController.searchBar.text, searchedText != "" {
            filteredStops = allStops.filter({$0.getName.contains(searchedText)})
        } else {
            filteredStops = allStops
        }
        mainStationTable.reloadData()
    }
}
