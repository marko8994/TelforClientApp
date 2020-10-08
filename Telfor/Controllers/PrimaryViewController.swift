//
//  PrimaryViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 07/10/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class PrimaryViewController: UITableViewController {
    
    private typealias Segues = StoryboardSegue.Main
        
    private var model: PrimaryInfoModel!
            
    private lazy var clientApiService = ClientApiService()
    
    private var imagePaths: [String]? {
        guard let model = model else { return nil }
        return (model.imagePaths.components(separatedBy: ", ")).compactMap {String($0)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.tabBarItem.title = model?.name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tabIndex = self.navigationController?.tabBarController?.selectedIndex,
            let tabItem = TabBarItem(rawValue: tabIndex), tabItem != .primary {
            self.navigationController?.tabBarItem.title = ""
        }
    }
    
    private func fetchData() {
        clientApiService.getPrimaryInfo { (primaryInfo, error) in
            guard error == nil else {
                return
            }
            guard let model = primaryInfo else {
                return
            }
            self.model = model
            self.title = model.name
            self.tableView.reloadData()
        }
    }
    
    private func setupCellInfo(for indexPath: IndexPath) -> BasicCellInfo {
        let section = model.sections[indexPath.section - 1]
        let session = section.sessions[indexPath.row]
        let userData = (section: section.name, sessionId: section.sessions[indexPath.row])
        return BasicCellInfo(userData: userData, title: session.name, subtitle: session.date.dateAndTime())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch Segues(segue) {
        case .sessionDetails:
            guard let viewController = segue.destination as? SessionDetailsViewController,
                let sessionId = sender as? String else { return }
            viewController.sessionId = sessionId
        default:
            return
        }
    }
}
    
    
    
extension PrimaryViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell, model != nil else { break }
            cell.configure(with: imagePaths?.first)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
                as? BasicTableViewCell else { break }
            cell.configure(with: setupCellInfo(for: indexPath))
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard model != nil else { return 0 }
        if section == 0 {
            return 1
        } else {
            return model.sections[section - 1].sessions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section != 0 else {
            return
        }
        let section = model.sections[indexPath.section - 1]
        let sessionId = section.sessions[indexPath.row].id
        perform(segue: Segues.sessionDetails, sender: sessionId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = model else { return 0 }
        return model.sections.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        } else {
             return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        let nibName = "SectionHeaderView"
        if let header = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? SectionHeaderView {
            header.configure(title: model.sections[section - 1].name,
                             hideButton: true,
                             backgroundColor: Theme.tertiaryColor)
            return header
        }
        fatalError("Can't find nib with name: \(String(describing: nibName))")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            return 44
        }
    }
}


