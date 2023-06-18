//
//  ViewController.swift
//  ListedApp
//
//  Created by Rahul Bawane on 15/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.registerNibs()
        self.viewModel.delegate = self
        self.viewModel.getData()
        self.tableView.layer.cornerRadius = 10
    }

    func registerNibs() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.register(UINib(nibName: "GraphTableViewCell", bundle: nil), forCellReuseIdentifier: "GraphTableViewCell")
        tableView.register(UINib(nibName: "AnalyticsTableViewCell", bundle: nil), forCellReuseIdentifier: "AnalyticsTableViewCell")
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
        tableView.register(UINib(nibName: "LinksTableViewCell", bundle: nil), forCellReuseIdentifier: "LinksTableViewCell")
        tableView.register(UINib(nibName: "LinkDataTableViewCell", bundle: nil), forCellReuseIdentifier: "LinkDataTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = self.viewModel.sections[section]
        if sectionType == .links {
            return self.viewModel.getLinksCount()
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = self.viewModel.sections[indexPath.section]
        switch sectionType {
        case .user:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            cell.setData(name: self.viewModel.getUserName())
            return cell
        case .graph:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GraphTableViewCell", for: indexPath) as? GraphTableViewCell else {
                return UITableViewCell()
            }
            cell.setChartsValue(values: self.viewModel.getChartsData())
            return cell
        case .analytics:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnalyticsTableViewCell", for: indexPath) as? AnalyticsTableViewCell else {
                return UITableViewCell()
            }
            cell.setCellData(data: self.viewModel.getAnalyticsData())
            return cell
        case .viewAnalytics, .viewAllLinks, .chat, .faq:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as? ButtonTableViewCell else {
                return UITableViewCell()
            }
            cell.setCellData(cellType: sectionType)
            return cell
        case .linkType:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinksTableViewCell", for: indexPath) as? LinksTableViewCell else {
                return UITableViewCell()
            }
            cell.setCellData(selectedType: self.viewModel.selectedLinkType)
            cell.delegate = self
            return cell
        case .links:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkDataTableViewCell", for: indexPath) as? LinkDataTableViewCell else {
                return UITableViewCell()
            }
            cell.setCellData(linkData: self.viewModel.getLinkData(index: indexPath.row))
            return cell
        }
    }
}

extension ViewController: DashboardViewModelToViewProtocol, LinksTableViewCellProtocol {
    func selectedLinkTypeChanged(type: LinkTypes) {
        self.viewModel.selectedLinkType = type
        self.tableView.reloadData()
    }
    
    func reloadDashboardData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
