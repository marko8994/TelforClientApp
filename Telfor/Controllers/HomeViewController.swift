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

class HomeViewController: UITableViewController {
    
    var sections: [HomeSection] = [.spotlight, .authors, .papers, .rooms]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Telfor 2019"
        tableView.tableFooterView = UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .spotlight:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
                as? SpotlightCell else { break }
            cell.configure(with: "https://i.imgur.com/mc9EqKh.jpeg")
            return cell
        case .authors:
            let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
            return cell
        case .papers:
            let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
            return cell
        case .rooms:
            let cell = tableView.dequeueReusableCell(withIdentifier: "spotlightCell", for: indexPath)
            return cell
        default:
            break
        }
        fatalError("Couldn't find cell for index path: \(String(describing: indexPath))")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .spotlight:
            return 1
        case .authors:
            return 5
        case .papers:
            return 5
        case .rooms:
            return 5
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = sections[indexPath.section]
        if section == .spotlight {
            return 250
        } else {
            return 50
        }
    }
}

