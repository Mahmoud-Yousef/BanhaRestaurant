//
//  mobileViewController.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 5/23/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import UIKit

class mobileViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("COUNTTTTT\(TotalBranchAndPhone.count)")
            return    TotalBranchAndPhone.count }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let   cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MobTableViewCell
            cell.mobileLbl.text = TotalBranchAndPhone[indexPath.row]
           // cell..text = TotalBranchAndPhone?[indexPath.row]
            if (TotalBranchAndPhone[indexPath.row] ).first == "0"
                {
                    cell.mobileLbl.textAlignment = NSTextAlignment.left
                }
                else {
                    cell.mobileLbl.textAlignment = NSTextAlignment.right
    
                }
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let number = URL(string: "tel://" + TotalBranchAndPhone[indexPath.row]) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                // Fallback on earlier versions
            }
    
            }
    var TotalBranchAndPhone = [String]()
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)

        super.viewDidLoad()
        TotalBranchAndPhone  = UserDefaults.standard.array(forKey: "TotalBranchAndPhone") as! [String]

        print("mmmmmmmm\(TotalBranchAndPhone)")// Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
