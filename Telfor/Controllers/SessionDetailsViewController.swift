//
//  SessionDetailsViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 07/10/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class SessionDetailsViewController: UITableViewController {
    
    private typealias Segues = StoryboardSegue.Session
    
    private enum SessionSection: Int {
        case info
        case chairpersons
        case papers
    }

    private enum SessionInfoRow: Int {
        case name = 0
        case date
        case room
    }
    
    var sessionId: String!
    
    private var session: Session!
    
    private lazy var clientApiService = ClientApiService()
    
    private var sections: [SessionSection] {
        guard session != nil else { return [SessionSection]() }
        var sections: [SessionSection] = [.info]
        if let chairpersons = session.chairpersons, chairpersons.count > 0 {
            sections.append(.chairpersons)
        }
        if let papers = session.papers, papers.count > 0 {
            sections.append(.papers)
        }
        return sections
    }
        
    private var infoRows: [SessionInfoRow] {
        return [.name, .date, .room]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.Common.sessionDetails
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        guard let sessionId = sessionId else { return }
        clientApiService.getSession(with: sessionId) { (session, error) in
            guard error == nil else {
                return
            }
            guard let session = session else {
                return
            }
            self.session = session
            self.tableView.reloadData()
        }
    }
    
    private func setCollectionItemSize(forItems items: [BasicCellInfo],
                                       cell: CollectionContainerCell,
                                       indexPath: IndexPath) {
        if let flowLayout = cell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            if DeviceInfo.isCompactScreen {
                flowLayout.itemSize.width = 140.0
            } else {
                flowLayout.itemSize.width = 160.0
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch Segues(segue) {
        case .authorDetails:
            guard let viewController = segue.destination as? AuthorDetailsViewController,
                let authorId = sender as? String else { return }
            viewController.authorId = authorId
        case .roomDetails:
            guard let viewController = segue.destination as? RoomDetailsViewController,
                let roomId = sender as? String else { return }
            viewController.roomId = roomId
        case .paperDetails:
            guard let viewController = segue.destination as? PaperDetailsViewController,
                let paperId = sender as? String else { return }
            viewController.paperId = paperId
        default:
            return
        }
    }
    
    private func infoSectionCellInfo(for indexPath: IndexPath) -> BasicCellInfo {
        let infoRow = infoRows[indexPath.row]
        let userData: UITableViewCell.AccessoryType
        switch infoRow {
        case .name:
            userData = .none
            return BasicCellInfo(userData: userData,title: session.name, subtitle: LocalizedStrings.Common.name)
        case .room:
            userData = .disclosureIndicator
            return BasicCellInfo(userData: userData, title: session.room.name, subtitle: LocalizedStrings.Common.room)
        case .date:
            userData = .none
            return BasicCellInfo(userData: userData, title: session.date.dateAndTime(),
                                 subtitle: LocalizedStrings.Common.presentationDate)
        }
    }
    
    private func chairpersonsSectionCellInfos() -> [BasicCellInfo]? {
        guard let chairpersons = session.chairpersons else { return nil }
        var chairpersonsCellInfos = [BasicCellInfo]()
        for chairperson in chairpersons {
            let userData = chairperson.id
            let cellInfo = BasicCellInfo(userData: userData, imagePath: chairperson.imagePath, title: chairperson.name)
            chairpersonsCellInfos.append(cellInfo)
        }
        guard chairpersonsCellInfos.count > 0 else { return nil }
        return chairpersonsCellInfos
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                as? BasicTableViewCell else { break }
            let cellInfo = infoSectionCellInfo(for: indexPath)
            cell.configure(with: cellInfo)
            return cell
        case .chairpersons:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionContainerCell", for: indexPath)
                as? CollectionContainerCell, let items = chairpersonsSectionCellInfos() else { break }
            cell.configure(items: items, actionDelegate: self)
            setCollectionItemSize(forItems: items, cell: cell, indexPath: indexPath)
            return cell
        case .papers:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "paperCell", for: indexPath)
                as? BasicTableViewCell, let paper = session?.papers?[indexPath.row] else { break }
            cell.configure(with: BasicCellInfo(with: paper))
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard session != nil else { return 0 }
        let section = sections[section]
        switch section {
        case .info:
            return infoRows.count
        case .chairpersons:
            guard let chairpersons = session.chairpersons else { return 0}
            return chairpersons.count > 0 ? 1: 0
        case .papers:
            return session?.papers?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .info:
            guard infoRows[indexPath.row] == .room, let roomId = session?.room.id else { return }
            perform(segue: Segues.roomDetails, sender: roomId)
        case .chairpersons: return
        case .papers:
            guard let papers = session.papers else { return }
            perform(segue: Segues.paperDetails, sender: papers[indexPath.row].id)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section] == .chairpersons {
            return 190
        } else {
           return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        var sectionTitle: String?
        var backgroundColor: UIColor?
        let nibName = "SectionHeaderView"
        switch section {
        case .info:
            sectionTitle = LocalizedStrings.Common.info
            backgroundColor = Theme.secondaryColor
        case .chairpersons:
            sectionTitle = LocalizedStrings.Common.chairpersons
            backgroundColor = Theme.quetarnaryColor
        case .papers:
            sectionTitle = LocalizedStrings.Common.papers
            backgroundColor = Theme.tertiaryColor
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
        return 44
    }
}

extension SessionDetailsViewController: CollectionContainerActionDelegate {
    
    public func cell(_ cell: CollectionContainerCell, collectionItemSelectedWithUserData userData: Any?) {
        if let params = userData as? String {
            perform(segue: Segues.authorDetails, sender: params)
        }
    }
}
