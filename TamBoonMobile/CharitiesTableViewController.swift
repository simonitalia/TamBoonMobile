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

        //trigger fetch of charities data fron remote api server on background thread
        performSelector(inBackground: #selector(fireFetchCharitiesList), with: nil)
        title = "Select Charity"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: Custom methods
    func updateUI() {
        //update UI on main thread so app doesn't crash
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    @objc func fireFetchCharitiesList() {
        let endpoint = APIEndpoint.charities.rawValue
        CharitiesController.shared.fetchCharitiesList(from: endpoint) { [unowned self] (data, error) in
            if let data = data {
                self.charities = data
                self.updateUI() //refresh tableView with fetched data
                print("TableVC successfully received Charities data: \(String(describing: self.charities))")
                
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
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
        
        //set cell imageView with charity logo
        let urlString = charity.logoURL
        let logo = CharitiesController.shared.fetchCharityLogo(from: urlString)
        cell.imageView?.image = logo
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
