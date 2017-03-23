//
//  ProgressViewController.swift
//  CIS55_FinalProject
//
//  Created by Patricia Caceres on 3/15/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData


extension NSDate {
    struct Gregorian {
        static let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    }
    var startOfWeek: NSDate {
        return Gregorian.calendar.date(from: Gregorian.calendar.components([.yearForWeekOfYear, .weekOfYear ], from: self as Date))! as NSDate
    }
}


class ProgressViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource {
 
    @IBOutlet var progressGraph: UIView!
    @IBOutlet var progressTrack: UICollectionView!
    @IBOutlet var motivPh: UITextView!
    @IBOutlet var progressAwards: UICollectionView!
    @IBOutlet var authorPh: UILabel!
    
    struct motivation {
        var phrase: String
        var name: String
    }
    
    struct dataStats {
        var title: String
        var points: Int
        var min: String
    }
    
    var today = NSCalendar.current.startOfDay(for: Date())
    
    var cellStats: [dataStats] = []
    var motivationalPhrases: [motivation] =
        [
            motivation(phrase:"Meditation is the discovery that the point of life is always arrived at in the immediate moment.", name:"ALAN WATTS"), motivation(phrase: "Meditation practice isn’t about trying to throw ourselves away and become something better, it’s about befriending who we are.", name: "ANI PEMA CHODRON"), motivation(phrase: "The you that goes in one side of the meditation experience is not the same you that comes out the other side.", name: "BHANTE HENEPOLA GUNARATANA"), motivation(phrase: "Meditation brings wisdom; lack of mediation leaves ignorance. Know well what leads you forward and what holds you back, and choose the path that leads to wisdom.", name: "BUDDHA"), motivation(phrase: "The things that trouble our spirits are within us already. In meditation, we must face them, accept them, and set them aside one by one.", name: "CRISTOPHER L BENNETT"), motivation(phrase: "Be conscious of yourself as consciousness alone, watch all the thoughts come and go. Come to the conclusion, by direct experience, that you are really consciousness itself, not its ephemeral contents.", name:"ANNAMALAI SWAMI"), motivation(phrase: "Meditation is not a way of making your mind quiet. It’s a way of entering into the quiet that’s already there – buried under the 50,000 thoughts the average person thinks every day.", name:"DEEPAK CHOPRA")
        ]
    var awardPoint = [1,3,10,15,30,90,180,365]
    var listofAwards: [UIImage] = []
    
    var myPoints : [ProgressPointsObjectMO] = []
    var dailyPoints: [ProgressPointsObjectMO] = []
    var OverallPoints : Int16 = 0
    
    var fetchResultsController : NSFetchedResultsController<ProgressPointsObjectMO>!
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count:Int?
        if collectionView == self.progressTrack{
            return 2
        }
        if collectionView == self.progressAwards{
            return listofAwards.count
        }
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         var cell:UICollectionViewCell?
        
        if collectionView == self.progressTrack{
            let cellA = progressTrack.dequeueReusableCell(withReuseIdentifier: "statisticCell", for: indexPath) as! StatisticsCollectionViewCell
            cellA.statsLabel.text = cellStats[indexPath.row].title
            cellA.statPoints.text =  "\(cellStats[indexPath.row].points)"
            cellA.minLabel.text = cellStats[indexPath.row].min
            return cellA
        }
        
        if collectionView == self.progressAwards{
            let cellB = progressAwards.dequeueReusableCell(withReuseIdentifier: "awardCell", for: indexPath) as! AwardCollectionViewCell
            cellB.awardImg.image = listofAwards[indexPath.row]
            cellB.pointsAw.text = "\(awardPoint[indexPath.row])"
            return cellB
            
        }
        return cell!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let background = CAGradientLayer().skyColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, at: 0)
        
        progressTrack.delegate = self
        progressTrack.dataSource = self
        
        progressAwards.delegate = self
        progressAwards.dataSource = self
        
        let range: UInt32 = UInt32(motivationalPhrases.count)
        let number = Int(arc4random_uniform(range))
        


        
        motivPh.text = motivPh.text!
        motivPh.text.append(motivationalPhrases[number].phrase)
        authorPh.text = motivationalPhrases[number].name
        

        // Do any additional setup after loading the view.
        
        let fetchRequest = NSFetchRequest<ProgressPointsObjectMO>(entityName: "ProgressPointsObject")
        
        let sortDescriptor = NSSortDescriptor(key: "progressDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    myPoints = fetchedObjects
                }
            }
            catch {
                print(error)
            }
        }
        //Prints Core Data to console
        print("Core Data array:")
        for i in 0..<myPoints.count{
            print(myPoints[i].progressDate)
            print(myPoints[i].progressPoints)
            print(myPoints[i].progressTotalTime)
        }

        
        
        
        var  j = 0
        
        //Zero-out time for date
        for thisProgressPoints in myPoints {
            let date = Date()
            let cal = Calendar(identifier: .gregorian)
            thisProgressPoints.progressDate = cal.startOfDay(for: thisProgressPoints.progressDate as! Date) as NSDate?
        }
        
        //If Core Data is not empty
        if (myPoints.count != 0)
        {
            dailyPoints.append(myPoints[0])
        
            //Remove duplicated entries from myPoints array
            for i in 1..<myPoints.count{
            
                if (myPoints[i].progressDate != myPoints[j].progressDate)
                {
                    j += 1
                    dailyPoints.append(myPoints[i])
                    dailyPoints[j].progressTotalTime += dailyPoints[j-1].progressTotalTime
                }
                else{
                    dailyPoints[j].progressPoints += myPoints[i].progressPoints
                    dailyPoints[j].progressTotalTime += myPoints[i].progressTotalTime
                }
            }
            
            //Prints dailyPoints Array to console
            print("dailyPoints Array:")
            for i in 0..<dailyPoints.count{
                print(dailyPoints[i].progressDate)
                print(dailyPoints[i].progressPoints)
                print(dailyPoints[i].progressTotalTime)
                OverallPoints += dailyPoints[i].progressTotalTime
            }
            

            //Displays information in the app
            //Last day in the array should be the current day
            cellStats.append(dataStats(title: "Today", points: Int(dailyPoints[dailyPoints.count-1].progressPoints), min:"min"))
            
            
            
            //Just add all progressTotalTime
            cellStats.append(dataStats(title: "Overall", points: Int(OverallPoints), min:"min"))
         
            //Depending on the number of days the user has used the app give them awards
            if (dailyPoints.count < awardPoint[0])
            {
                for i in 0...7{
                listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[1])
            {
                listofAwards.append(#imageLiteral(resourceName: "award"))
                for i in 0...6{
                    listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[2])
            {
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                for i in 0...5{
                    listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[3])
            {
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                for i in 0...4{
                    listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[4])
            {
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                for i in 0...3{
                    listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[5])
            {
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                listofAwards.append(#imageLiteral(resourceName: "award"))
                for i in 0...2{
                    listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                }
            }
            else if (dailyPoints.count < awardPoint[6])
            {
                for i in 0...5{
                    listofAwards.append(#imageLiteral(resourceName: "award"))
                }
                listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
                listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
            }
            else if (dailyPoints.count < awardPoint[7])
            {
                for i in 0...6{
                listofAwards.append(#imageLiteral(resourceName: "award"))
                }
                listofAwards.append(#imageLiteral(resourceName: "grayscaleAward"))
            
            }
            else{
                for i in 0...7{
                    listofAwards.append(#imageLiteral(resourceName: "award"))
                }
            }

        }
        else {
            //If there is no information in the CoreData
            cellStats.append(dataStats(title: "Today", points: 0, min:"min"))
            cellStats.append(dataStats(title: "Overall", points: 0, min:"min"))
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
