//
//  ViewController2.swift
//  Konsijerz
//
//  Created by Nikola Ilic on 17.7.23..
//

import UIKit

class ViewController2: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        parkirani.loadFromFile()
        self.mojaTabela2.dataSource = self
        
    }
    
    @IBOutlet weak var mojaTabela2: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkirani.sviParkirani.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celija2 = tableView.dequeueReusableCell(withIdentifier: "cell2")
        celija2?.textLabel?.text = parkirani.sviParkirani[indexPath.row].marka
        celija2?.detailTextLabel?.text = parkirani.sviParkirani[indexPath.row].registracija
        return celija2!
    }
    

    
    
   
    
}


