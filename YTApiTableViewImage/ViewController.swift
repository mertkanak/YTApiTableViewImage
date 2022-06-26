//
//  ViewController.swift
//  YTApiTableViewImage
//
//  Created by mert Kanak on 27.06.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableView: UITableView!
    var heroes: [HeroStats] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
            print("success")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let hero = heroes[indexPath.row]
        cell.textLabel?.text = hero.localized_name.capitalized
        cell.detailTextLabel?.text = hero.primary_attr.capitalized
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[tableView.indexPathForSelectedRow!.row]
        }
    }

    func downloadJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api.opendota.com/api/heroStats")
        
        URLSession.shared.dataTask(with: url!)  { data, response, err in
            
            if err == nil {
                do {
                    self.heroes = try JSONDecoder().decode([HeroStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error fetching data from api")
                }
            }
        }.resume()
    }
}

