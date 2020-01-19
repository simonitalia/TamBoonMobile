//
//  CharitiesListTableTableViewController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class CharitiesTableViewController: UITableViewController {
    
    //property to store list of charities, once data fetched from remote server
    var charities = [Charity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set initial title
        title = "Loading..."

        //trigger fetch of charities data fron remote api server on background thread
        performSelector(inBackground: #selector(fireGetCharitiesList), with: nil)
        
        tableView.tableFooterView = UIView()
        //hides empty row seperators
    }
    
    //MARK: Custom methods
    func updateUI() {
        //update UI on main thread so app doesn't crash
        DispatchQueue.main.async { [unowned self] in
            self.title = "Select Charity"
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.tableView.reloadData()
        }
    }
    
    @objc func fireGetCharitiesList() {
        CharitiesController.shared.getCharitiesList() { [unowned self] (charities) in
            if let charities = charities {
                self.charities = charities
                self.updateUI() //refresh tableView with fetched data
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
            //only 1 section in this app
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }

    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard charities.count != 0 else { fatalError("Charity Cell cannot be created") }
        
        //reference charity object for row
        let charity = charities[indexPath.row]
        
        //configure cell with data from charity object
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharityCell", for: indexPath)
        cell.textLabel?.text = charity.name

        return cell
    }
    

    // MARK: - Navigation
    //setup segue to destination vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get destinaton view controller
        if segue.identifier == "CharitiesTableVCToCharityDetailVC" {
            let vc = segue.destination as! CharityDetailViewController
            let rowTapped = tableView.indexPathForSelectedRow!.row
            
            //pass tapped charity object to destinaiton vc
            vc.charity = charities[rowTapped]
        
        } else {
            print("Failed to push to CharityDetailVC")
        }
    }
    
    //unwind segue to present this vc after donation transaction is complete
    @IBAction func unwindToCharitiesTableVC(segue: UIStoryboardSegue) {
    }
    

}


