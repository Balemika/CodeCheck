//
//  DetailViewController.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 18/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // Array from FDA API
    var fdaAPI: [Results] = []
    let arrayOfButtons = ["1","7","20"]
    // master array
    lazy var rowsToDisplay: [Results] = fdaAPI
    let tableView = UITableView(frame: .zero, style: .plain)
    

    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: arrayOfButtons)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleChangeSegment), for: .valueChanged)
        return sc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        
        configureManager()
        configureStackView()
    }
    
    
    func configureManager() {
        var Manager = FDAManager()
        Manager.delegate = self
        Manager.fetchAPI(limit: 20)
    }
    
    
    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView])
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
    // Segment was changed
    @objc fileprivate func handleChangeSegment() {
        if fdaAPI.isEmpty { return }
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            rowsToDisplay = Array(arrayLiteral: fdaAPI[0])
        case 1:
            rowsToDisplay = Array(fdaAPI[0...6])
        default:
            rowsToDisplay = fdaAPI
        }
        tableView.reloadData()
    }
}


extension DetailViewController: FDAManagerDelegate {
    func didUpdateAPI(_ codeManager: FDAManager, api: [Results]) {
        DispatchQueue.main.async {
            self.fdaAPI = api
            self.rowsToDisplay = Array(arrayLiteral: api[0])
            self.tableView.reloadData()
        }
    }
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate{
    
    // Count of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsToDisplay.count
    }
    

    // Sets the title for rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        DispatchQueue.main.async {
            cell.textLabel?.text = self.rowsToDisplay[indexPath.row].city
        }
        return cell
    }
}
