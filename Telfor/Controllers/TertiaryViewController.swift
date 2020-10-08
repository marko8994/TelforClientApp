//
//  InfoTableViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class TertiaryViewController: UITableViewController {
    
    private enum InfoSection: Int {
        case spotlight = 0
        case description
        case info
    }
    
    private enum InfoRow: Int {
        case startDate = 0
        case endDate
        case surveyForm
        case contact
    }
    
    private var sections: [InfoSection] = [.spotlight, .description, .info]
    
    private var infoRows: [InfoRow] = [.startDate, .endDate, .surveyForm, .contact]
    
    private var infoModel: TertiaryInfoModel!
    
    private lazy var clientApiService = ClientApiService()
    
    private var imagePaths: [String]? {
        guard let model = infoModel else { return nil }
        return (model.imagePaths.components(separatedBy: ", ")).compactMap {String($0)}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarItem.title = infoModel?.name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tabIndex = self.navigationController?.tabBarController?.selectedIndex,
            let tabItem = TabBarItem(rawValue: tabIndex), tabItem != .tertiary {
            self.navigationController?.tabBarItem.title = ""
        }
    }
    
    private func fetchData() {
        clientApiService.getTertiaryInfo { (response, error) in
            guard error == nil else {
                return
            }
            guard let response = response else {
                return
            }
            self.infoModel = response
            self.title = self.infoModel.name
            self.tableView.reloadData()
        }
    }
    
    private func infoSectionCellInfo(for indexPath: IndexPath) -> BasicCellInfo {
        let infoRow = infoRows[indexPath.row]
        switch infoRow {
        case .startDate:
            return BasicCellInfo(title: infoModel.startDate.dateAndTime(),
                                 subtitle: LocalizedStrings.Common.startDate)
        case .endDate:
            return BasicCellInfo(title: infoModel.endDate.dateAndTime(),
                                 subtitle: LocalizedStrings.Common.endDate)
        case .surveyForm:
            return BasicCellInfo(title: LocalizedStrings.Common.survey)
        case .contact:
            return BasicCellInfo(title: LocalizedStrings.Common.contact)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: imagePaths?.first)
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
                as? TableTextViewCell else { break }
            cell.content = infoModel.description
            return cell
        case .info:
            let infoRow = infoRows[indexPath.row]
            let cellIdentifier = infoRow == .startDate || infoRow == .endDate ? "infoCell" : "disclosureCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? BasicTableViewCell else { break }
            cell.configure(with: infoSectionCellInfo(for: indexPath))
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard infoModel != nil else { return 0 }
        let section = sections[section]
        switch section {
        case .spotlight, .description:
            return 1
        case .info:
            return infoRows.count
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            return 250
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        guard section != .spotlight else { return nil }
        var sectionTitle: String?
        var backgroundColor: UIColor?
        let nibName = "SectionHeaderView"
        switch section {
        case .description:
            sectionTitle = LocalizedStrings.Common.summary
            backgroundColor = Theme.secondaryColor
        case .info:
            sectionTitle = LocalizedStrings.Common.info
            backgroundColor = Theme.tertiaryColor
        default:
            return nil
        }
        if let header = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? SectionHeaderView {
            header.configure(userData: section,
                             title: sectionTitle!,
                             hideButton: true,
                             backgroundColor: backgroundColor,
                             actionDelegate: nil)
            return header
        }
        fatalError("Can't find nib with name: \(String(describing: nibName))")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section] == .spotlight {
            return CGFloat.leastNormalMagnitude
        } else {
            return 44
        }
    }
}

