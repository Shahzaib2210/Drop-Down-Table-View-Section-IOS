//
//  ViewController.swift
//  TableViewDropDown
//
//  Created by Shahzaib Mumtaz on 30/03/2022.
//

import UIKit

class Section {
    
    let title: String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String,
         options: [String],
         isOpened: Bool = false ) {
        
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tablcview : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Sections
        
        sections = [
            Section(title: "Section A", options: [1,2,3].compactMap({"Option \($0)"})),
            Section(title: "Section B", options: [1,2,3].compactMap({"Option \($0)"})),
            Section(title: "Section C", options: [1,2,3].compactMap({"Option \($0)"})),
            Section(title: "Section D", options: [1,2,3].compactMap({"Option \($0)"}))
        ]
        
        view.addSubview(tablcview)
        tablcview.delegate = self
        tablcview.dataSource = self
        
        tablcview.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        
        if section.isOpened {
            return section.options.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .red
        } else {
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .green
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tablcview.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            
            print("Sub Cell Tapped")
        }
    }
}
