//
//  ViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 25/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

enum HomeSection: Int {
    case spotlight = 0
    case authors
    case papers
    case rooms
}

typealias CellActionsDelegate =  CollectionContainerActionDelegate & SectionHeaderActionDelegate

typealias HomeModel = (imagePath: String, authors: [LightAuthor], papers: [LightPaper], rooms: [LightRoom])

class HomeViewController: UITableViewController {
    
    private var model: HomeModel!
    private var cellInfos = [HomeSection: [BasicCellInfo]]()
    
    weak var cellActionsDelegate: CellActionsDelegate?
    
    var sections: [HomeSection] = [.spotlight, .authors, .papers, .rooms]
    
    var authors = [LightAuthor(uid: "", name: "AuthorOne", imagePath: "https://i.imgur.com/mc9EqKh.jpeg"),
                   LightAuthor(uid: "", name: "AuthorTwo", imagePath: nil),
                   LightAuthor(uid: "", name: "AuthorThree", imagePath: nil),
                   LightAuthor(uid: "", name: "AuthorFour", imagePath: nil),
                   LightAuthor(uid: "", name: "AuthorFive", imagePath: nil),
                   LightAuthor(uid: "", name: "AuthorSix", imagePath: nil),
                   LightAuthor(uid: "", name: "AuthorSeven", imagePath: nil)]
    
    var papers = [LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"]),
                  LightPaper(uid: "", title: "PaperOne", authorNames: ["AuthorOne", "AuthorTwo"])]
    
    var rooms = [LightRoom(uid: "", name: "RoomOne"),
                 LightRoom(uid: "", name: "RoomTwo"),
                 LightRoom(uid: "", name: "RoomThree"),
                 LightRoom(uid: "", name: "RoomFour"),
                 LightRoom(uid: "", name: "RoomFive"),
                 LightRoom(uid: "", name: "RoomSix"),
                 LightRoom(uid: "", name: "RoomSeven"),
                 LightRoom(uid: "", name: "RoomEight"),
                 LightRoom(uid: "", name: "RoomNine"),
                 LightRoom(uid: "", name: "RoomTen"),
                 LightRoom(uid: "", name: "RoomEleven")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Telfor 2019"
        fetchData()
        setupCellInfos()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        model = HomeModel(imagePath: "https://i.imgur.com/mc9EqKh.jpeg",
                          authors: authors, papers: papers, rooms: rooms)
    }
    
    private func setupCellInfos() {
        var authorCellInfos = [BasicCellInfo]()
        for author in model.authors {
            let userData = (section: HomeSection.authors, authorUid: author.uid)
            let cellInfo = BasicCellInfo(userData: userData, imagePath: author.imagePath, title: author.name)
            authorCellInfos.append(cellInfo)
        }
        cellInfos[.authors] = authorCellInfos
        var paperCellInfos = [BasicCellInfo]()
        for paper in model.papers {
            let userData = (section: HomeSection.papers, paperUid: paper.uid)
            let cellInfo = BasicCellInfo(userData: userData, title: paper.title, subtitle: paper.authorNames.joined(separator: ", "))
            paperCellInfos.append(cellInfo)
        }
        cellInfos[.papers] = paperCellInfos
        var roomCellInfos = [BasicCellInfo]()
        for room in model.rooms {
            let userData = (section: HomeSection.papers, roomUid: room.uid)
            let cellInfo = BasicCellInfo(userData: userData, title: room.name)
            roomCellInfos.append(cellInfo)
        }
        cellInfos[.rooms] = roomCellInfos
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
            
//            if items.count == 1 {
//                let collectionViewSectionPadding: CGFloat = 15
//                flowLayout.itemSize.width = UIScreen.main.bounds.width - (collectionViewSectionPadding * 2)
//            } else {
//                if DeviceInfo.isCompactScreen {
//                    flowLayout.itemSize.width = 140.0
//                } else {
//                    flowLayout.itemSize.width = 160.0
//                }
//            }
        }
    }
}
    
    
    
extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: model.imagePath)
            return cell
        case .authors:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "collectionContainerCell", for: indexPath)
                as? CollectionContainerCell, let items = cellInfos[section] else { break }
            cell.configure(items: items, actionDelegate: self)
            setCollectionItemSize(forItems: items, cell: cell, indexPath: indexPath)
            return cell
        case .papers:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "paperCell", for: indexPath)
                as? BasicTableViewCell, let cellInfos = cellInfos[section] else { break }
            cell.configure(with: cellInfos[indexPath.row])
            return cell
        case .rooms:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath)
                as? BasicTableViewCell, let cellInfos = cellInfos[section] else { break }
            cell.configure(with: cellInfos[indexPath.row])
            return cell
            
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .spotlight, .authors:
            return 1
        default:
            return cellInfos[section]?.count ?? 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            return 250
        case .authors:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        guard section != .spotlight else { return nil }
        var sectionTitle: String?
        let nibName = "SectionHeaderView"
        switch section {
        case .authors:
            sectionTitle = "Authors"
        case .papers:
            sectionTitle = "Papers"
        case .rooms:
            sectionTitle = "Rooms"
        default:
            return nil
        }
        if let header = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? SectionHeaderView {
            let hideButton = cellInfos[section]?.count ?? 0 <= 10
            header.configure(userData: section,
                             title: sectionTitle!,
                             hideButton: hideButton,
                             actionDelegate: cellActionsDelegate)
            return header
        }
        fatalError("Can't find nib with name: \(String(describing: nibName))")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        switch section {
        case .authors, .papers, .rooms:
            return 34
        default:
            return CGFloat.leastNormalMagnitude
        }
    }
}

extension HomeViewController: CollectionContainerActionDelegate {
    
    public func cell(_ cell: CollectionContainerCell, collectionItemSelectedWithUserData userData: Any?) {
        if let params = userData as? (HomeSection, String) {
            let section = params.0
            let itemUid = params.1
            switch section {
            case .authors:
                performSegue(withIdentifier: "authorDetails", sender: itemUid)
            case .papers:
                performSegue(withIdentifier: "paperDetails", sender: itemUid)
            case .rooms:
                performSegue(withIdentifier: "roomDetails", sender: itemUid)
            default:
                return
            }
        }
    }
}


