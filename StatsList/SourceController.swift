//
//  SourceController.swift
//  StatsList
//
//  Created by 123 on 17.07.23.
//

import Foundation
import UIKit
import SnapKit

class SourceController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newData: [String] = []
    let tableView = UITableView()
    var players = [Statistic]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: "SourceTableViewCell")
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    
        guard let url = URL(string: "https://hltv-api.vercel.app/api/match.json") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }else if let usableData = data,
                     let response = response as?
                        HTTPURLResponse, response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let playersData = try decoder.decode([Statistic].self, from: usableData)
                    
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.players = playersData.filter {$0.team.lowercased() == "navi"}
                        DataStore.shared.players = playersData
                        
                        
                    }
                    
                }catch{
                    print("Error decoding: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    func showPlayersDetails() {
        let playerDetails = PlayerDetailsViewController()
        navigationController?.pushViewController(playerDetails, animated: true)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newData.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceTableViewCell", for: indexPath) as! SourceTableViewCell
        cell.textLabel?.text = newData[indexPath.row]
         cell.textLabel?.textAlignment = .left
         
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sourceController = SourceController()

        let playerDetails = PlayerDetailsViewController()
        navigationController?.pushViewController(playerDetails, animated: true)
    }


    
}

class SourceTableViewCell: UITableViewCell {
   
}

class DataStore {
    static let shared = DataStore()
    
    var players = [Statistic]()
    private init() {}
}
