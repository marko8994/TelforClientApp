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
    
    var authorId: String!
    
    var author: Author!
    
    var sections: [AuthorSection] {
        return [.spotlight, .info, .biography, .papers]
    }
        
    var infoRows: [AuthorInfoRow] = [.name, .organization, .position]
    
    private lazy var clientApiService = ClientApiService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedStrings.Common.authorDetails
        fetchData()
        tableView.tableFooterView = UIView()
    }
    
    private func fetchData() {
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

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: "https://i.imgur.com/mc9EqKh.jpeg")
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
                as? BasicTableViewCell, let papers = author.papers else { break }
            cell.configure(with: BasicCellInfo(with: papers[indexPath.row]))
            return cell
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }
    
    private func infoSectionCellInfo(for indexPath: IndexPath) -> BasicCellInfo {
        let infoRow = infoRows[indexPath.row]
        switch infoRow {
        case .name:
            return BasicCellInfo(title: LocalizedStrings.Common.name, subtitle: author.name)
        case .organization:
            return BasicCellInfo(title: LocalizedStrings.Common.organization, subtitle: author.organization)
        case .position:
            return BasicCellInfo(title: LocalizedStrings.Common.position, subtitle: author.position)
        }
        
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
            return author.papers?.count ?? 0
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        switch section {
        case .info:
            return LocalizedStrings.Common.info
        case .biography:
            return LocalizedStrings.Common.biography
        case .papers:
            return LocalizedStrings.Common.papers
        default:
            return nil
        }
    }

}
