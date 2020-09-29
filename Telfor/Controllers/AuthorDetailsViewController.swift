//
//  AuthorDetailsViewController.swift
//  Telfor
//
//  Created by Marko Mladenovic on 27/09/2020.
//  Copyright © 2020 Marko Mladenovic. All rights reserved.
//

import UIKit

enum AuthorSection: Int {
    case spotlight = 0
    case info
    case biography
    case papers
}

enum AuthorInfoRow: Int {
    case name = 0
    case organization
    case position
}

class AuthorDetailsViewController: UITableViewController {
    
    private typealias Segues = StoryboardSegue.Author
    
    private enum AuthorSection: Int {
        case spotlight = 0
        case info
        case biography
        case papers
    }

    private enum AuthorInfoRow: Int {
        case name = 0
        case organization
        case position
    }
    
    var authorId: String!
    
    private var author: Author!
    
    private var sections: [AuthorSection] {
        return [.spotlight, .info, .biography, .papers]
    }
        
    private var infoRows: [AuthorInfoRow] = [.name, .organization, .position]
    
    private lazy var clientApiService = ClientApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.Common.authorDetails
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
        guard let authorId = authorId else { return }
        clientApiService.getAuthor(with: authorId) { (response, error) in
            guard error == nil else {
                return
            }
            guard let response = response else {
                return
            }
            self.author = response.author
            self.author.papers = response.papers
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch Segues(segue) {
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
        switch infoRow {
        case .name:
            return BasicCellInfo(title: author.name, subtitle: LocalizedStrings.Common.name)
        case .organization:
            return BasicCellInfo(title: author.organization, subtitle: LocalizedStrings.Common.organization)
        case .position:
            return BasicCellInfo(title: author.position, subtitle: LocalizedStrings.Common.position)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: author?.imagePath)
            return cell
        case .info:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                as? BasicTableViewCell else { break }
            let cellInfo = infoSectionCellInfo(for: indexPath)
            cell.configure(with: cellInfo)
            return cell
        case .biography:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "biographyCell", for: indexPath)
                as? TableTextViewCell else { break }
            cell.content = author.biography
            return cell
        case .papers:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "paperCell", for: indexPath)
                as? BasicTableViewCell, let papers = author?.papers else { break }
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
        guard author != nil else { return 0 }
        let section = sections[section]
        switch section {
        case .spotlight:
            return 1
        case .info:
            return infoRows.count
        case .biography:
            return 1
        case .papers:
            return author?.papers?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard sections[indexPath.section] == .papers, let paperId = author?.papers?[indexPath.row].id else { return }
        perform(segue: Segues.paperDetails, sender: paperId )
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
            backgroundColor = Theme.secondaryColor
        case .biography:
            sectionTitle = LocalizedStrings.Common.biography
            backgroundColor = Theme.tertiaryColor
        case .papers:
            sectionTitle = LocalizedStrings.Common.papers
            backgroundColor = Theme.quetarnaryColor
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
