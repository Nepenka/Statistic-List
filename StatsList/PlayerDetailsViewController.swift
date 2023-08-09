//
//  PlayerDetailsViewController.swift
//  StatsList
//
//  Created by 123 on 20.07.23.
//

import Foundation
import UIKit
import SnapKit

class PlayerDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell", for: indexPath) as! PlayersCell
        
        cell.textLabel?.textAlignment = .center
        let player = players[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
   
    
    
    var players: [Statistic] {
           return DataStore.shared.players
       }

    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(PlayersCell.self, forCellReuseIdentifier: "PlayersCell")
        
    }
    
    func setupUI() {
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
    }
}

class PlayersCell: UITableViewCell {
    
}
