//
//  feelingsTableViewController.swift
//  CIS55_FinalProject
//
//  Created by Jan on 3/15/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class feelingsTableViewController: UITableViewController {
    
    var mySongList =
    [
            SongListObject(songFileName: NSDataAsset(name: "Guided")!, songType: "guided", songEmotion: "Happy", songImage: #imageLiteral(resourceName: "natureback"), songDuration: 5)
            ,SongListObject(songFileName: NSDataAsset(name:"Nature")!, songType: "sounds", songEmotion: "Stressed", songImage: #imageLiteral(resourceName: "natureback-1"), songDuration: 10)
            ,SongListObject(songFileName: NSDataAsset(name: "RelaxingMusic")!, songType: "sounds", songEmotion: "Calm", songImage: #imageLiteral(resourceName: "natureback"), songDuration: 15)
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mySongList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "myFeelingsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeelingsTableViewCell
        
        
        var cellItem : SongListObject
            cellItem = mySongList[indexPath.row]
        
        cell.emotionName?.text = cellItem.songEmotion
        cell.songImage?.image = cellItem.songImage
    
        return cell

    }
    
    func animateTable(){
        tableView.reloadData()
        let cells = tableView.visibleCells
        
        let tableViewHeight = tableView.bounds.size.height
        
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y:tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells{
            UIView.animate(withDuration: 2, delay: Double(delayCounter)*0.05, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "playEmotion" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let playMusicVC = segue.destination as! playMusicViewController
                projectUtil.originatingScreen = "hrufeeling"
                projectUtil.duration = 5
                projectUtil.songFileName = mySongList[indexPath.row].songFileName
                projectUtil.duration = Double(mySongList[indexPath.row].songDuration)
            }
        }
    }
 
    

}
