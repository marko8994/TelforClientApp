//
//  RoomDetailsViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 29/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class RoomDetailsViewController: UITableViewController {
    
    private enum RoomSection: Int {
        case spotlight = 0
        case info
        case papers
    }
    
    var roomId: String!
    
    private var room: Room!
    
    private var sections: [RoomSection] {
        var sections: [RoomSection] = [.spotlight, .info]
        if room?.papers?.count ?? 0 > 0 {
            sections.append(.papers)
        }
        return sections
    }

    private lazy var clientApiService = ClientApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.Common.authorDetails
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        guard let roomId = roomId else { return }
        clientApiService.getRoom(with: roomId) { (response, error) in
            guard error == nil else {
                return
            }
            guard let response = response else {
                return
            }
            self.room = response.room
            self.room.papers = response.papers
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if StoryboardSegue.Room(segue) == .paperDetails {
            guard let viewController = segue.destination as? PaperDetailsViewController,
                let paperId = sender as? String else { return }
            viewController.paperId = paperId
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: room?.mapPath)
            return cell
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                as? BasicTableViewCell else { break }
            let cellInfo = BasicCellInfo(title: room.name, subtitle: LocalizedStrings.Common.name)
            cell.configure(with: cellInfo)
            return cell
        case .papers:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "paperCell", for: indexPath)
                as? BasicTableViewCell, let papers = room?.papers else { break }
            cell.configure(with: BasicCellInfo(with: papers[indexPath.row]))
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard room != nil else { return 0 }
        let section = sections[section]
        switch section {
        case .spotlight, .info:
            return 1
        case .papers:
            return room?.papers?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard sections[indexPath.section] == .papers, let paperId = room?.papers?[indexPath.row].id else { return }
        perform(segue: StoryboardSegue.Room.paperDetails, sender: paperId)
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
        case .info:
            sectionTitle = LocalizedStrings.Common.info
            backgroundColor = .yellow
        case .papers:
            guard room?.papers?.count ?? 0 > 0 else { return nil }
            sectionTitle = LocalizedStrings.Common.papers
            backgroundColor = .red
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
