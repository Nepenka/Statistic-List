//
//  SecondViewController.swift
//  StatsList
//
//  Created by 123 on 8.07.23.
//



import UIKit
import SnapKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Comands.comands.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = Comands.comands[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textAlignment = .center
        
        
        if indexPath.row == 0 {
            cell.photoImageView.image = UIImage(named: "insilio")
        } else if indexPath.row == 1 {
            cell.photoImageView.image = UIImage(named: "navi")
        } else if indexPath.row == 2 {
            cell.photoImageView.image = UIImage(named: "spirit")
        } else if indexPath.row == 3 {
            cell.photoImageView.image = UIImage(named: "astralis")
        } else if indexPath.row == 4 {
            cell.photoImageView.image = UIImage(named: "virtuspro")
        } else if indexPath.row == 5 {
            cell.photoImageView.image = UIImage(named: "heroic")
        } else if indexPath.row == 6 {
            cell.photoImageView.image = UIImage(named: "faze")
        } else if indexPath.row == 7 {
            cell.photoImageView.image = UIImage(named: "vitality")
        } else if indexPath.row == 8 {
            cell.photoImageView.image = UIImage(named: "g2")
        } else if indexPath.row == 9 {
            cell.photoImageView.image = UIImage(named: "ence")
        } else if indexPath.row == 10 {
            cell.photoImageView.image = UIImage(named: "cloud9")
        } else if indexPath.row == 11 {
            cell.photoImageView.image = UIImage(named: "monte")
        } else if indexPath.row == 12 {
            cell.photoImageView.image = UIImage(named: "nip")
        } else if indexPath.row == 13 {
            cell.photoImageView.image = UIImage(named: "1win")
        } else if indexPath.row == 14 {
            cell.photoImageView.image = UIImage(named: "forze")
        } else if indexPath.row == 15 {
            cell.photoImageView.image = UIImage(named: "teamliquid")
        } else {
            cell.photoImageView.image = nil
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sourceController = SourceController()
        
        if indexPath.row == 0 {
            sourceController.newData = ["Polt", "k4sl-", "Xant3r", "Pipw", "Dadte"]
        }else if indexPath.row == 1 {
            sourceController.newData = ["s1mple", "Aleksib", "iM", "b1t", "jL"]
        }else if indexPath.row == 2 {
            sourceController.newData = ["chopper", "magixx", "zont1x", "donk", "ArtFr0st"]
        }else if indexPath.row == 3 {
            sourceController.newData = ["device", "b0RUP", "blameF", "Staehr", "Buzz"]
        }else if indexPath.row == 4 {
            sourceController.newData = ["FL1T", "Qikert", "Jame", "n0rb3r7", "fame"]
        }else if indexPath.row == 5 {
            sourceController.newData = ["cadiaN", "stavn", "TeSeS", "sjuush", "jabbi"]
        }else if indexPath.row == 6 {
            sourceController.newData = ["karrigan", "rain", "Twistzz", "ropz", "broky"]
        }else if indexPath.row == 7 {
            sourceController.newData = ["apEX", "Magisk", "ZywOo", "flameZ", "SpinX"]
        }else if indexPath.row == 8 {
            sourceController.newData = ["NiKo", "huNter-", "jks", "HooXi", "m0nNESY"]
        }else if indexPath.row == 9 {
            sourceController.newData = ["Snappi", "NertZ", "Maden", "dycha", "SunPayus"]
        }else if indexPath.row == 10 {
            sourceController.newData = ["HObbit", "electroNic", "Ax1Le", "sh1ro", "Perfecto"]
        }else if indexPath.row == 11 {
            sourceController.newData = ["sdy", "br0", "Woro2k", "DemQQ", "kRaSnaL"]
        }else if indexPath.row == 12 {
            sourceController.newData = ["k0nfig", "REZ", "hampus", "Brollan", "headtr1ck"]
        }else if indexPath.row == 13 {
            sourceController.newData = ["NickelBack", "BoombI4", "Forester", "TRAVIS", "deko"]
        }else if indexPath.row == 14 {
            sourceController.newData = ["Krad", "Jerry", "zorte", "shalfey", "r3salt"]
        }else if indexPath.row == 15 {
            sourceController.newData = ["NAF", "oSee", "YEKINDAR", "Rainwaker", "Patsi"]
        }
        navigationController?.pushViewController(sourceController, animated: true)
    }
    
    
    
    var comand: [Comands] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.navigationItem.title = "Static List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }
    
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


class TableViewCell: UITableViewCell {
    let photoImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFit
           imageView.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
           return imageView
       }()

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           addSubview(photoImageView)
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
