//
//  MainScreenTableViewController.swift
//  HooMi
//
//  Created by Родион on 15.01.2018.
//  Copyright © 2018 Rodion Kuskov. All rights reserved.
//

import UIKit
import Firebase
class MainScreenTableViewController: UITableViewController, UISearchBarDelegate {
    

    
    var mixes = [Mix]()
    var keys : [String] = []
    var ref : DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        inserting()
        setupNavBar()
        
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            getChildID()
//            let time = DispatchTime.now() + 1
//            DispatchQueue.main.asyncAfter(deadline: time, execute: {
//                self.ref?.child("Mix").child(self.keys[indexPath.row]).removeValue()
//                self.mixes.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .automatic)
//                self.keys = []
//            })
//        }
//    }
//
//    func getChildID() {
//        ref?.child("Mix").observeSingleEvent(of: .value, with: { (snapshot) in
//            for child in snapshot.children {
//                let snap = child as! DataSnapshot
//                let key = snap.key
//                self.keys.append(key)
//
//            }
//
//        })
//
//    }
    
    func inserting() {
        Database.database().reference().child("Mix").observe(.childAdded) { (snapshot) in
            DispatchQueue.main.async {
                let newMix = Mix(snapshot: snapshot)
                self.mixes.insert(newMix, at: 0)
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .top)
            }
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mixes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainScreenTableViewCell
        cell.mix = self.mixes[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailScreenViewController
            detailVC.detail = sender as? Mix
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mix = mixes[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: mix)
    }

}
