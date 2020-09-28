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

class HomeViewController: UITableViewController {
    
    private typealias Segues = StoryboardSegue.Main
    
    private var model: HomeModel!
    private var cellInfos = [HomeSection: [BasicCellInfo]]()
    
    weak var cellActionsDelegate: CellActionsDelegate?
    
    var sections: [HomeSection] = [.spotlight, .authors, .papers, .rooms]
    
    private lazy var homeApiService = ClientMainService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Telfor 2019"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        homeApiService.getAll(limit: 10) { (homeData, error) in
            guard error == nil else {
                return
            }
            guard let model = homeData else {
                return
            }
            self.model = model
            self.setupCellInfos()
            self.tableView.reloadData()
        }
    }
    
    private func setupCellInfos() {
        var authorCellInfos = [BasicCellInfo]()
        for author in model.authors {
            let userData = (section: HomeSection.authors, authorUid: author.id)
            let cellInfo = BasicCellInfo(userData: userData, imagePath: author.imagePath, title: author.name)
            authorCellInfos.append(cellInfo)
        }
        cellInfos[.authors] = authorCellInfos
        var paperCellInfos = [BasicCellInfo]()
        for paper in model.papers {
            let cellInfo = BasicCellInfo(title: paper.title, subtitle: paper.authorNames.joined(separator: ", "))
            paperCellInfos.append(cellInfo)
        }
        cellInfos[.papers] = paperCellInfos
        var roomCellInfos = [BasicCellInfo]()
        for room in model.rooms {
            let cellInfo = BasicCellInfo(title: room.name)
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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch Segues(segue) {
        case .authorDetails:
            guard let viewController = segue.destination as? AuthorDetailsViewController,
                let author = sender as? Author else { return }
            viewController.author = author
        default:
            return
        }
    }
}
    
    
    
extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell, let model = model else { break }
            cell.configure(with: "https://i.imgur.com/mc9EqKh.jpeg")
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
            if model != nil {
                return 1
            } else {
                return 0
            }
        default:
            return cellInfos[section]?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        switch section {
        case .papers:
            return
        default:
            return
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
            sectionTitle = LocalizedStrings.Common.authors
        case .papers:
            sectionTitle = LocalizedStrings.Common.papers
        case .rooms:
            sectionTitle = LocalizedStrings.Common.rooms
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
        if let params = userData as? (HomeSection, Author), params.0 == .authors {
            perform(segue: Segues.authorDetails, sender: params.1)
        }
    }
}


