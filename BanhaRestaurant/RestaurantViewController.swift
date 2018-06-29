//
//  RestaurantViewController.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 4/22/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher
import FirebaseDatabase
import Firebase
import FirebaseCore
import ImageSlideshow
import Kingfisher
import SwiftyJSON
import MapKit
struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}
class RestaurantViewController:  UIViewController,UIViewControllerTransitioningDelegate,UITableViewDataSource,UITableViewDelegate{
    var tableViewData = [cellData]()

    @IBOutlet var branchTableView: UITableView!
    @IBOutlet var imageSlider: ImageSlideshow!
    @IBOutlet var menuBtn: UIBarButtonItem!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var Return : Int = 0
        if tableView == branchTableView {
            if tableViewData[section].opened == true{
                Return = branchArray.count
            }
            else {
                Return = 1
            }
        }
        return Return
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell1:UITableViewCell?

            print("branchArraybranchArraybranchArray\(branchArray.count)")
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
                print("mmmm\(branchArray)")
                if  branchArray.first != nil {
                    tableViewData[indexPath.section].title = branchArray[0]
                    
                }
                cell.textLabel?.textAlignment = NSTextAlignment.right
                cell.textLabel?.text = tableViewData[indexPath.section].title
                cell1 = cell
            }
        
                  if branchArray.count  > 1{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
                tableViewData[indexPath.section].sectionData[indexPath.row ] = branchArray[indexPath.row ]
                cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row ]
                cell1 = cell
        }
        return cell1!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == branchTableView{
            if indexPath.row == 0 {
                if tableViewData[indexPath.section].opened == true {
                    print(">>> true")
                    tableViewData[indexPath.section].opened = false
                    let sections = IndexSet.init(integer : indexPath.section)
                    branchTableView.reloadSections(sections, with: .automatic)
                }
                else if tableViewData[indexPath.section].opened == false{
                    print(">>> false")
                    tableViewData[indexPath.section].opened = true
                    let sections = IndexSet.init(integer : indexPath.section)
                    branchTableView.reloadSections(sections, with: .automatic)
                }
            }
        }
        }
    
    @IBOutlet var backBtn: UIBarButtonItem!
    let locationManager = CLLocationManager()
    var ref: DatabaseReference!
    var ref3: DatabaseReference!
    var lat : Double = 0
    var lng : Double = 0
    var reversedImages = [String]()
    var newMenuArray = [String]()
    var shakwaRef: DatabaseReference!

    var transitionDelegate: ZoomAnimatedTransitioningDelegate?
    var ref2: DatabaseReference!
var phoneArray = [String]()
    var menuArray = [String]()
    var branchArray = [String]()
    var TotalbranchArray = [String]()
    var TotalBranchAndPhone = [String]()
    var shakawaNumber = ""
    @IBOutlet var TitleLbl: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var Logo: UIImageView!
    @IBOutlet var categoryLbl: UILabel!
    @IBOutlet var time: UILabel!
    
    @IBOutlet var topView: UIView!
    @IBOutlet var angryBtn: UIButton!
    @IBOutlet var CosmosView: CosmosView!
    var Images = [String]()
    let SelectedRestCategory = UserDefaults.standard.string(forKey: "SelectedRestCategory")
    let SelectedRate = UserDefaults.standard.string(forKey: "SelectedRate")
    let SelectedLogo = UserDefaults.standard.string(forKey: "SelectedLogo")
    let selectedRest = UserDefaults.standard.string(forKey: "SelectedRest")
     let SelectedRestKey = UserDefaults.standard.string(forKey: "SelectedRestKey")
    override func viewDidLoad() {
        tableViewData = [cellData(opened : false , title : "..", sectionData : ["cell1","cell2"])]
        branchTableView.separatorStyle = .none
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        backBtn.action = #selector(backFunc)
        Logo.layer.cornerRadius = Logo.frame.size.width / 2;
        Logo.clipsToBounds = true
        print("Sselecteeeeed \(SelectedLogo!)\(selectedRest!)&&&")
        print("\(SelectedRestKey!)")
        transitioningDelegate = self
        TitleLbl.text = selectedRest
        category.text = SelectedRestCategory
        let url = URL(string: "\(SelectedLogo!)")
        Logo.kf.setImage(with: url)
        Logo.layer.cornerRadius = CGFloat(Float(5.0));
        Logo.layer.cornerRadius = Logo.frame.size.width / 2;
        let myDouble = ((SelectedRate)! as NSString).doubleValue
        print("Mydouble \(myDouble)")
        CosmosView.rating = Double(myDouble)
        retriveData()
        branchFunc()
        TotalBranchAndPhone = []
        shakwaFunc()
        sideMenus()
    }
    override func viewDidAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: true)

    }
    func sideMenus(){
        
        if self.revealViewController() != nil {
            menuBtn.target = self.revealViewController()
            menuBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 275
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = lng
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = selectedRest
        mapItem.openInMaps(launchOptions: options)
    }
    
    func Imageslide(){
        super.viewDidLoad()
        if let  MenuArrayy = UserDefaults.standard.array(forKey: "MenuArray") {
            menuArray = MenuArrayy as! [String]
            print("SLIDEImageeees\(menuArray)")

        }
        for i in menuArray {
            print("menu Array \(i)")
            
            let UrlString :String = i.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
            print("new Menu Array \(UrlString)")
            self.newMenuArray.append(UrlString)
            
        }
        reversedImages = []
        for arrayIndex in 0..<newMenuArray.count {
            reversedImages.append(newMenuArray[(newMenuArray.count - 1) - arrayIndex])
        }
        let kingfisherSource = self.reversedImages.map { KingfisherSource( urlString: $0) }
        imageSlider.setImageInputs(kingfisherSource as! [InputSource])
        imageSlider.contentScaleMode = .scaleAspectFit
        imageSlider.pageControl.currentPageIndicatorTintColor = UIColor.white
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RestaurantViewController.didTap))
        imageSlider.addGestureRecognizer(gestureRecognizer)
    }
      @objc  func didTap() {
        imageSlider.presentFullScreenController(from: self)
    }
     @objc func backFunc() {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    
    func retriveData(){
        menuArray = []
        let Menuref = Database.database().reference().child("restaurant/\(SelectedRestKey!)");
        Menuref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild("menu"){
                print("Trueeee menu exist")
                    let Object = snapshot.childSnapshot(forPath: "menu")
                    let Menu = Object.value! as? [String:String]
                    for (key,value) in Menu! {
                        self.menuArray.append(value)
                        UserDefaults.standard.set(self.menuArray, forKey: "MenuArray")
                    }
            }
//
            else{
                self.menuArray = []
                UserDefaults.standard.set(self.menuArray, forKey: "MenuArray")
                print("false menu doesn't exist")
            }
            self.Imageslide()
        })
//
//        menuArray = []
//        ref = Database.database().reference().child("restaurant/\(SelectedRestKey!)/menu");
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            let menu = snapshot.value as? [String: String]
//            for (key,value) in menu! {
//                print("XXXXXXXXXX")
//            self.menuArray.append(value)
//                print("LLLLL\(self.menuArray)")
//                UserDefaults.standard.set(self.menuArray, forKey: "MenuArray")
//
//            }
//completion()
//    })

        ref2 = Database.database().reference().child("restaurant/\(SelectedRestKey!)/delTime");
        ref2.observeSingleEvent(of: .value, with: { (snapshot) in
            let delTime = snapshot.value
            print("TIMEEEEEE\(String(describing: delTime))")
            self.time.text = delTime as! String
        })
        ref3 = Database.database().reference().child("restaurant/\(SelectedRestKey!)/rate/total");
        ref3.observeSingleEvent(of: .value, with: { (snapshot) in
            let rate = snapshot.value
            print("Rateeee\(String(describing: rate))")
          //  self.time.text = delTime as! String
            let myDouble = ((rate) as! NSString).doubleValue
            print("Mydouble \(myDouble)")
            self.CosmosView.rating = Double(myDouble)
        })

    }
    func branchFunc(){
        branchArray = []
        let refbranch = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch");
        refbranch.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                
                //clearing the list
               // self.BranchDataModel.removeAll()
                
                //iterating through all the values
                for branch in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    //getting values
                    let branchObject = branch.value as? [String: AnyObject]
                    let branchKey = branch.key
                    print("brachkeeeeeey\(branchKey)")
                    UserDefaults.standard.set(branchKey, forKey: "branchKeyDefault")
                    let SelectedRestKey = UserDefaults.standard.string(forKey: "SelectedRestKey")
//////////////////////////////////
//                    let details = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch/phone")
//                    details.observe(DataEventType.value, with: { (snapshot) in
//                        let detail = snapshot.value as? [String: String]

                     //   let detail = snapshot.value  as! String
                                                                //for (key,value) in detail! {
                                                                //print("KEyy\(key)>>>>>>>>>>>>\(value)")
                         //   self.valueArray.append("\(value)")
                          //  self.Dic[restkey] = self.valueArray
                   //     }
                     //   print("detail\(detail))")
                     //   self.rateArray.append(rate)
                       // UserDefaults.standard.set(self.rateArray, forKey: "rateArray")
                        
                //    })
//////////////////////////////////////
                     let details = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch/\(branchKey)/details")
                    details.observeSingleEvent(of: .value, with: { (snapshot) in
                    let detail = snapshot.value as! String
                    print("DEtaaails\(detail)")
                    let Total = "\(branchKey), \(detail)"
                        print("TOTAAAAAAL\(Total)")
                        self.branchArray.append(Total)
                        print("Branch\(self.branchArray)")
                     //   self.dropDown.dataSource = self.branchArray
                       // self.dropDown.show()
                        self.branchTableView.reloadData()

                       
                    })

                    self.TotalBranchAndPhone.append(branchKey)

                    let phone = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch/\(branchKey)/phone")
                    phone.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.childrenCount > 0 {
                            
                            //clearing the list
                            self.phoneArray.removeAll()
                            
                            //iterating through all the values
                            for phone in snapshot.children.allObjects as! [DataSnapshot] {
                                
                                //getting values
                                let phoneObject = phone.value as? [String: AnyObject]
                                let phone = phone.key
                                print("phonekeeeeeey\(phone)")

                                self.phoneArray.append(phone)
                                self.TotalBranchAndPhone.append(phone)
                    }
                            
                        }
                      
                        print("TotalbranchAndPhone\(self.TotalBranchAndPhone)")
                        print("TotalbranchAndPhoneCount\(self.TotalBranchAndPhone.count)")
                        
                    })
                    
                    ////////////
                    let map = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch/\(branchKey)/map/lat")
                    map.observeSingleEvent(of: .value, with: { (snapshot) in
                        let latitude = snapshot.value as! String
                        let myDouble = ((latitude) as NSString).doubleValue
                        print("Mydouble \(myDouble)")
                        self.lat = Double(myDouble)
                        
                        
                    })
                    let maplng = Database.database().reference().child("restaurant/\(SelectedRestKey!)/branch/\(branchKey)/map/lng")
                    maplng.observeSingleEvent(of: .value, with: { (snapshot) in
                        let longitude = snapshot.value as! String
                        let myDouble = ((longitude) as NSString).doubleValue
                        print("Mydouble \(myDouble)")
                        self.lng = Double(myDouble)
//                        print("LNGGGGG\(self.lng)")
                        
                        
                    })
                /////////////
                }

            }

})
}
    
    func shakwaFunc(){
        shakwaRef = Database.database().reference().child("restaurant/\(SelectedRestKey!)/shkawa");
        shakwaRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let shakawa = snapshot.value as! String
            print("shakawaaaaaa\(String(describing: shakawa))")
            self.shakawaNumber = shakawa
        })
    }
    
    @IBAction func angryPressed(_ sender: Any) {
        print("Shakwaaaaa")
        let alert = UIAlertController(title: "Shakwa",message: "shakwa??", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title:"Ok" , style: UIAlertActionStyle.default, handler:{ _ in
            guard let number = URL(string: "tel://" + self.shakawaNumber) else { return }
         //   if #available(iOS 10.0, *) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                print("XXXX")
            }
     
        }))
         alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func mobilePressedd(_ sender: Any) {
        print("TotalbranchAndPhone\(self.TotalBranchAndPhone)")
        print("TotalbranchAndPhoneCount\(self.TotalBranchAndPhone.count)")
        UserDefaults.standard.set(TotalBranchAndPhone, forKey: "TotalBranchAndPhone")
        performSegue(withIdentifier: "goToMobile", sender: self)
     //   mobileTableView.isHidden = false
       // mobileCanelBtn.isHidden = false
    //    topView.isHidden = true
     //   menuLbl.isHidden = true
      //  imageSlider.isHidden = true

    }
    @IBOutlet var mobilePressed: UIButton!
    @IBAction func mapPressed(_ sender: Any) {
        openMapForPlace()
    }
   
    
    
//    @IBAction func mobileCancelPressed(_ sender: Any) {
//      /  mobileTableView.isHidden = true
//        mobileCanelBtn.isHidden = true
//        topView.isHidden = false
//        menuLbl.isHidden = false
//        imageSlider.isHidden = false
//    }
}

