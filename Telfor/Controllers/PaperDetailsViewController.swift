//
//  PaperDetailsViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 28/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

class PaperDetailsViewController: UITableViewController {
    
    private typealias Segues = StoryboardSegue.Paper
    
    private enum PaperSection: Int {
        case info
        case summary
        case authors
    }

    private enum PaperInfoRow: Int {
        case title = 0
        case type
        case presentationDate
        case room
        case questionForm
    }
    
    var paperId: String!
    
    private var paper: Paper!
    
    private lazy var clientApiService = ClientApiService.shared
    
    private var sections: [PaperSection] {
        var sections: [PaperSection] = [.info, .summary]
        if paper?.authors != nil {
            sections.append(.authors)
        }
        return sections
    }
        
    private var infoRows: [PaperInfoRow] {
        var rows: [PaperInfoRow] = [.title, .type, .presentationDate, .room]
        if paper?.questionsFormPath != nil {
            rows.append(.questionForm)
        }
        return rows
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.Common.paperDetails
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        guard let paperId = paperId else { return }
        clientApiService.getPaper(with: paperId) { (paper, error) in
            guard error == nil else {
                return
            }
            guard let paper = paper else {
                return
            }
            self.paper = paper
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
        default:
            return
        }
    }
    
    private func infoSectionCellInfo(for indexPath: IndexPath) -> BasicCellInfo {
        let infoRow = infoRows[indexPath.row]
        let userData: UITableViewCell.AccessoryType
        switch infoRow {
        case .title:
            userData = .none
            return BasicCellInfo(userData: userData,title: paper.title , subtitle: LocalizedStrings.Common.title)
        case .type:
            userData = .none
            return BasicCellInfo(userData: userData, title: paper.type.name,
                                 subtitle: LocalizedStrings.Common.paperType)
        case .room:
            userData = .disclosureIndicator
            return BasicCellInfo(userData: userData, title: paper.room.name, subtitle: LocalizedStrings.Common.room)
        case .questionForm:
            userData = .disclosureIndicator
            return BasicCellInfo(userData: userData, title: LocalizedStrings.Common.questionsForm)
        case .presentationDate:
            userData = .none
            return BasicCellInfo(userData: userData, title: paper.presentationDate.dateAndTime(),
                                 subtitle: LocalizedStrings.Common.presentationDate)
        }
    }
    
    private func authorsSectionCellInfos() -> [BasicCellInfo]? {
        guard let authors = paper.authors else { return nil }
        var authorCellInfos = [BasicCellInfo]()
        for author in authors {
            let userData = author.id
            let cellInfo = BasicCellInfo(userData: userData, imagePath: author.imagePath, title: author.name)
            authorCellInfos.append(cellInfo)
        }
        guard authorCellInfos.count > 0 else { return nil }
        return authorCellInfos
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .info:
            let cellIdentifier = infoRows[indexPath.row] == .questionForm ? "questionsCell" : "infoCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                as? BasicTableViewCell else { break }
            let cellInfo = infoSectionCellInfo(for: indexPath)
            cell.configure(with: cellInfo)
            return cell
        case .summary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
                as? TableTextViewCell else { break }
            cell.content = paper.summary
            return cell
        case .authors:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionContainerCell", for: indexPath)
                as? CollectionContainerCell, let items = authorsSectionCellInfos() else { break }
            cell.configure(items: items, actionDelegate: self)
            setCollectionItemSize(forItems: items, cell: cell, indexPath: indexPath)
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard paper != nil else { return 0 }
        let section = sections[section]
        switch section {
        case .info:
            return infoRows.count
        case .summary, .authors:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard infoRows[indexPath.row] == .room, let roomId = paper?.room.id else { return }
        perform(segue: Segues.roomDetails, sender: roomId)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section] == .authors {
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
        case .summary:
            sectionTitle = LocalizedStrings.Common.summary
            backgroundColor = Theme.tertiaryColor
        case .authors:
            sectionTitle = LocalizedStrings.Common.authors
            backgroundColor = Theme.quetarnaryColor
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

extension PaperDetailsViewController: CollectionContainerActionDelegate {
    
    public func cell(_ cell: CollectionContainerCell, collectionItemSelectedWithUserData userData: Any?) {
        if let params = userData as? String {
            perform(segue: Segues.authorDetails, sender: params)
        }
    }
}
