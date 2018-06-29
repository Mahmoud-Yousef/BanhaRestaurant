//
//  sideBarViewController.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 5/15/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import UIKit

class sideBarViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! sideBarTableViewCell
        cell.cellLbl.text = CellsArray[indexPath.row]
        cell.cellImg.image = Images[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let revealViewController: SWRevealViewController =  self.revealViewController()
        let cell:sideBarTableViewCell = tableView.cellForRow(at: indexPath) as! sideBarTableViewCell
        if cell.cellLbl.text! == "اضافة مطعم"
            
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://www.messenger.com/t/311686062357097")! as URL , options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }

        }
        else if cell.cellLbl.text! == "اخبار وصفات الطعام"
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://www.facebook.com/BanhaRestaurants/")! as URL , options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        else if cell.cellLbl.text! == "شكاوى و اقتراحات"
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "https://www.messenger.com/t/311686062357097")! as URL , options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        else if cell.cellLbl.text! == "الدعم الفنى للتطبيق"
            
        {
            let Number = "01065359772"
            guard let number = URL(string: "tel://" + Number ) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                print("XXXX")
            }
        }
        
    }
    
    var CellsArray:Array  = [String]()
    var Images:Array  = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        CellsArray = ["اضافة مطعم","اخبار وصفات الطعام","شكاوى و اقتراحات","الدعم الفنى للتطبيق"]
    
    Images = [UIImage(named: "add")!,UIImage(named: "fb")!,UIImage(named: "shkawa")!,UIImage(named: "callus")!]
    }



}
