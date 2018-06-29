//
//  InitialViewController.swift
//  BanhaRestaurant
//
//  Created by Shimaa Elcc on 4/13/18.
//  Copyright © 2018 Shimaa Elcc. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher
import FirebaseDatabase
import Firebase
import FirebaseCore
import SwiftyJSON
import Cosmos
import SVProgressHUD
class InitialViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet var mobileTableView: UITableView!
    
    @IBOutlet var mobileOk: UIButton!
    @IBOutlet var searchBtn: UIBarButtonItem!
    @IBOutlet var CategoryTableView: UITableView!

    @IBOutlet var menuBtn: UIBarButtonItem!
    @IBOutlet var Filter: UIButton!
    @IBOutlet var Search: UISearchBar!

    var selectedCategory = ""
    var Dic = [ String : [String]]()
     var spareDic = [ String : [String]]()
    var restName = [String]()
    var filteredData: [String]!
var newLogoArray = [String]()
    var valueArray = [String]()
    var Categories = [String]()
   var menuArray = [String]()
    var rateArray = [String]()
    var slideImages = [String]()
    var sponsorNames = [String]()
    var SpareLogoArray = [String]()
    var SpareRestKey = [String]()
    var SpareRateArray = [String]()
    var spareRestName = [String]()
        var newRestkey = [String]()
    var newRateArray = [String]()
    var newrestName = [String]()
    var newCategoryArray = [String]()
    var newDic = [String]()
    var FilterDataIndexArray = [Int]()
    var branchArray = [String]()
    var TotalbranchArray = [String]()
    var TotalBranchAndPhone = [String]()
    var phoneArray = [String]()

    @IBOutlet var filterImg: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet var filterResult: UIButton!
    var refArtists: DatabaseReference!
    var ref: DatabaseReference!
    var ref3: DatabaseReference!
    var sponserRef : DatabaseReference!
    var databaseHandle:DatabaseHandle?
    var postData = [String]()
    var restkeAyrray = [String]()
    var CategoryArray = [String]()
    var CategoryArrayDefault = [String]()
    var logoArray = [String]()
    var typeArray = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var Return : Int = 0
        if tableView == tableview {
            Return =  filteredData.count
        }
        else if tableView == CategoryTableView {
            Return = Categories.count
        }
        else if tableView == mobileTableView{
            Return = TotalBranchAndPhone.count
        }
        return Return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //var cell:UITableViewCell?
        var cell1:UITableViewCell?
        if tableView == self.tableview {
          let   cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! initialTableViewCell
            if let  Dicc = UserDefaults.standard.dictionary(forKey: "Dic")
            {
                Dic = Dicc as! [String : [String]]
              let newArray = Dic[restkeAyrray[indexPath.row]]!
              let arr = newArray.map { (string) -> String in
              return String("-\(string) ")
               }.joined()
        print("NEWWWWWWWARRAAAAAY................\(arr)")
               cell.secondLbl.text = arr
            }
     let url = URL(string: "\(logoArray[indexPath.row])")
     cell.cellImg.kf.indicatorType = .activity
     cell.cellImg.kf.setImage(with: url)
            if let  restNamee = UserDefaults.standard.array(forKey: "restName")
            {
                restName = restNamee as! [String]
            }
            cell.firstLbl.text = filteredData[indexPath.row]
            if let  rateArrayy = UserDefaults.standard.array(forKey: "rateArray")
            {
                rateArray = rateArrayy as! [String]
                print("COUNTTTTTTTTTT\(rateArray.count)")

                let myDouble = ((rateArray[indexPath.row]) as NSString).doubleValue
                print("Mydouble \(myDouble)")
                cell.CosmosView.rating = Double(myDouble)
            }
            cell.callBtn.tag = indexPath.row

            cell.callBtn.addTarget(self, action:#selector(call), for: .touchUpInside)

            cell1 = cell
        }
        else if tableView == CategoryTableView  {
            let  cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterTableViewCell
            
            cell.CellLbl.text =  Categories[indexPath.row]
            cell1 = cell
        }
        if tableView == mobileTableView {
            
            let   cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MobileTableViewCell
            if TotalBranchAndPhone.count != 0 {
            cell.Mob.text = TotalBranchAndPhone[indexPath.row]
            if TotalBranchAndPhone[indexPath.row].first == "0"
            {
                cell.Mob.textAlignment = NSTextAlignment.left
            }
            else {
                cell.Mob.textAlignment = NSTextAlignment.right

            }
            }
            cell1 = cell
            
        }
        
        return cell1!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableview {

            UserDefaults.standard.set(restkeAyrray[indexPath.row], forKey: "SelectedRestKey")
            UserDefaults.standard.set(logoArray[indexPath.row], forKey: "SelectedLogo")
            UserDefaults.standard.set(filteredData[indexPath.row], forKey: "SelectedRest")
            print("restName\(filteredData[indexPath.row])")
           // Menu()
            if let  rateArrayy = UserDefaults.standard.array(forKey: "rateArray")
            {
                rateArray = rateArrayy as! [String]
                UserDefaults.standard.set(rateArray[indexPath.row], forKey: "SelectedRate")
            }
            if let  Dicc = UserDefaults.standard.dictionary(forKey: "Dic")
            {
                Dic = Dicc as! [String : [String]]
                let newArray = Dic[restkeAyrray[indexPath.row]]!
                
                let arr = newArray.map { (string) -> String in
                    return String("-\(string) ")
                    }.joined()
                UserDefaults.standard.set(arr, forKey: "SelectedRestCategory")

            }
            
            
            performSegue(withIdentifier: "goToRest", sender: self)
        }
        else if tableView == CategoryTableView {
        UserDefaults.standard.set(Categories[indexPath.row],forKey: "SelectedCategory")
        ////////////
            if let  Dicc = UserDefaults.standard.dictionary(forKey: "Dic")
            {
                Dic = Dicc as! [String : [String]]
                //            for i in 0...Dicc.count-1 {
                //            let newArray = Dic[restkeAyrray[i]]!
                //
                //            let arr = newArray.map { (string) -> String in
                //                return String("\(string)  ")
                //                }.joined()
                //            }
            }
        CategoryTableView.isHidden = true
        filterResult.isHidden = true
        tableview.isHidden = false
        ImageSlideShow.isHidden = false
        Filter.isHidden = false
        filterImg.isHidden = false
            
        
        if let selected = UserDefaults.standard.string(forKey: "SelectedCategory"){
            self.selectedCategory = selected
            updateCategory(Category : selectedCategory)
            print("Seleected\(self.selectedCategory)")
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addTapped))
            let backImg: UIImage = UIImage(named: "search1")!
            navigationItem.leftBarButtonItem?.setBackgroundImage(backImg, for: .normal, barMetrics: .default)
            print("Apppeaaaaar")
        }
            tableview.reloadData()
        }
        else if tableView == mobileTableView
        {
            guard let number = URL(string: "tel://" + TotalBranchAndPhone[indexPath.row]) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number)
            } else {
                // Fallback on earlier versions
            }

        }
    }
    @objc func call(sender: UIButton ){
        print("CALLLLLL")
        let buttonTag = sender.tag
        print("INDEEEX\(buttonTag)")
        let SelectedRestKey = restkeAyrray[buttonTag]
        print(SelectedRestKey)
        TotalBranchAndPhone = []
        CALL(selected: SelectedRestKey)
        mobileTableView.isHidden = false
        mobileOk.isHidden = false
        tableview.isHidden = true
        CategoryTableView.isHidden = true
        filterResult.isHidden = false
        ImageSlideShow.isHidden = true
        Filter.isHidden = true
        filterImg.isHidden = true
        

    }
    func updateCategory(Category : String ){
       
        SpareRestKey = UserDefaults.standard.array(forKey: "restkeAyrray") as! [String]
        SpareRateArray = UserDefaults.standard.array(forKey: "rateArray") as! [String]
        SpareLogoArray = UserDefaults.standard.array(forKey: "logoArray") as! [String]
        spareRestName = UserDefaults.standard.array(forKey: "restName") as! [String]
        spareDic = UserDefaults.standard.dictionary(forKey: "Dic") as! [String : [String]]
        newLogoArray = []
        newRateArray = []
        newRestkey = []
        filteredData = []
        newrestName = []
        FilterDataIndexArray = []
        newCategoryArray = []
        
        for i in 0...Dic.count-1 {
            if (spareDic[SpareRestKey[i]]?.contains("\(Category)"))!{
                print("TUREEEE")
               FilterDataIndexArray.append(i)
            }
            else {
                print("Falseeee")
            }
        
    }
        print("FilterDataIndexArray\(FilterDataIndexArray)")
        
        spareDic = UserDefaults.standard.dictionary(forKey: "Dic") as! [String : [String]]
        
        if FilterDataIndexArray.count != 0 {
        for i in 0...FilterDataIndexArray.count-1 {
            
            newLogoArray.append(SpareLogoArray[FilterDataIndexArray[i]])
        }
        for i in 0...FilterDataIndexArray.count-1 {
            
            newRestkey.append(SpareRestKey[FilterDataIndexArray[i]])
        }
        for i in 0...FilterDataIndexArray.count-1 {
            
            newRateArray.append(SpareRateArray[FilterDataIndexArray[i]])
        }
        for i in 0...FilterDataIndexArray.count-1 {
            
            newrestName.append(spareRestName[FilterDataIndexArray[i]])
        }
    
//        for i in 0...FilterDataIndexArray.count-1 {
//
//            newDic[restkeAyrray[FilterDataIndexArray[i]]] = spareDic[restkeAyrray[FilterDataIndexArray[i]]]
//        }
      
        logoArray = newLogoArray
        rateArray = newRateArray
        restkeAyrray = newRestkey
        filteredData = newrestName
        }
     //   Dic[restkeAyrray] = newDic
        print("RESTNAMEEEE\(filteredData)")
    }
    //////////////////////////////////////////////////////////////////////////////////////
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("BEGIIIINNNN>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
NotificationCenter.default.addObserver(self, selector: #selector(InitialViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        FilterDataIndexArray = []
        if let  restNamee = UserDefaults.standard.array(forKey: "restName")
        {
            restName = restNamee as! [String]
        }
        filteredData = searchText.isEmpty ? restName : restName.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
        //    print("Filtereeeeeeeed\(filteredData)")
    
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        if filteredData.count != 0 {
        for i in 0...filteredData.count-1 {
            let Index = restName.index(of: filteredData[i])
            FilterDataIndexArray.append(Index!)
        }
        print("FilterDataIndexArray\(FilterDataIndexArray)")
        newLogoArray = []
        newRateArray = []
        newRestkey = []
        SpareRestKey = UserDefaults.standard.array(forKey: "restkeAyrray") as! [String]
         SpareRateArray = UserDefaults.standard.array(forKey: "restkeAyrray") as! [String]
        SpareLogoArray = UserDefaults.standard.array(forKey: "logoArray") as! [String]
        for i in 0...filteredData.count-1 {
            
            newLogoArray.append(SpareLogoArray[FilterDataIndexArray[i]])
        }
        for i in 0...filteredData.count-1 {
            
            newRestkey.append(SpareRestKey[FilterDataIndexArray[i]])
        }
        for i in 0...filteredData.count-1 {
            
            newRateArray.append(SpareRateArray[FilterDataIndexArray[i]])
        }
        logoArray = newLogoArray
        rateArray = newRateArray
        restkeAyrray = newRestkey
        tableview.reloadData()
        }
   
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        NotificationCenter.default.addObserver(self, selector: #selector(InitialViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        print("end searching --> Close Keyboard")
        self.Search.endEditing(true)
        
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("BEGIIIIIIIIINNNNNNNNN??????????????????????????????????????")
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
         print(keyboardSize)
            bottomConstraint?.constant = -(keyboardSize.height )
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint?.constant = 0
        }
    }
    var bottomConstraint : NSLayoutConstraint?
    var Images:Array  = [UIImage]()
    @IBOutlet var ImageSlideShow: ImageSlideshow!
    override func viewDidLoad() {
        
        TotalBranchAndPhone = []
        mobileTableView.isHidden = true
        mobileOk.isHidden = true
        mobileOk.layer.cornerRadius = CGFloat(Float(5.0));
        self.CategoryTableView.separatorStyle = .none
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        Search.isHidden = true
        bottomConstraint = NSLayoutConstraint(item: tableview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        Search.isHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(addTapped))
        let backImg: UIImage = UIImage(named: "search1")!
        navigationItem.leftBarButtonItem?.setBackgroundImage(backImg, for: .normal, barMetrics: .default)
        Categories = []
        rateArray = []
        Dic = [:]
        restName = []
        sponsorNames = []
        typeArray = []
        Search.delegate = self
        CategoryTableView.delegate = self
        CategoryTableView.dataSource = self
        CategoryTableView.isHidden = true
        filterResult.isHidden = true
        self.filterImg.layer.cornerRadius = self.filterImg.frame.size.width / 2;
        self.filterImg.clipsToBounds = true
        categories()
        retrieveRest()
        sponser(completion : Imageslide)
        sideMenus()
    }
    func sideMenus(){
        
        if self.revealViewController() != nil {
            menuBtn.target = self.revealViewController()
            menuBtn.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            self.revealViewController().rightViewRevealWidth = 275
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    @objc func addTapped(){
        print("SEARCHHHTAPPED")
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        Search.isHidden = false
    
    }
    //////////////////////
    
    
    
    //////////////////////
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        Search.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)

      //  Search.showsCancelButton = false
      //  Search.text = ""
      //  Search.resignFirstResponder()

    }
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? restName : restName.filter({(dataString: String) -> Bool in
           //     return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
                return (dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil)
            })
            
            tableview.reloadData()
        }
    }
    func Imageslide(){
        super.viewDidLoad()
        print("SLIDESSSSSSS")
        if let  slideImagess = UserDefaults.standard.array(forKey: "slideImages") {
            slideImages = slideImagess as! [String]
            print("SLIDEImageeees\(slideImages)")
            let kingfisherSource = self.slideImages.map { KingfisherSource( urlString: $0) }
            ImageSlideShow.setImageInputs(kingfisherSource as! [InputSource])
        }
        ImageSlideShow.slideshowInterval = 3;
        ImageSlideShow.pageControlPosition = .custom(padding: -20)
        ImageSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.white
        
        ImageSlideShow.activityIndicator = DefaultActivityIndicator()
        ImageSlideShow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InitialViewController.didTap))
        ImageSlideShow.addGestureRecognizer(gestureRecognizer)
    }

    @objc func didTap() {
        let index = ImageSlideShow.currentPage
        print("InDEEEEEEEX\(index)")
        if typeArray[index] == "restaurant"{
        print("SPONSORNAAAAAME\(sponsorNames[index])")
        let RstKeyIndex = restkeAyrray.index(of: sponsorNames[index])
        print("RstKeyIndexRstKeyIndex\(String(describing: RstKeyIndex))")

        //////////////////////////////
        UserDefaults.standard.set(restkeAyrray[RstKeyIndex!], forKey: "SelectedRestKey")
        UserDefaults.standard.set(logoArray[RstKeyIndex!], forKey: "SelectedLogo")
        UserDefaults.standard.set(restName[RstKeyIndex!], forKey: "SelectedRest")
        
        // Menu()
        if let  rateArrayy = UserDefaults.standard.array(forKey: "rateArray")
        {
            rateArray = rateArrayy as! [String]
            UserDefaults.standard.set(rateArray[RstKeyIndex!], forKey: "SelectedRate")
        }
        if let  Dicc = UserDefaults.standard.dictionary(forKey: "Dic")
        {
            Dic = Dicc as! [String : [String]]
            let newArray = Dic[restkeAyrray[RstKeyIndex!]]!
            
            let arr = newArray.map { (string) -> String in
                return String("-\(string) ")
                }.joined()
            UserDefaults.standard.set(arr, forKey: "SelectedRestCategory")

        }
        /////////////////////
        
        
        performSegue(withIdentifier: "goToRest", sender: self)
    }
    }
  
    func retrieveRest(){
        CategoryArrayDefault = []
        restkeAyrray = []
        rateArray = []
        restName = []
        filteredData = []
        //Dic = [:]
        SVProgressHUD.show()
        refArtists = Database.database().reference()
        var ar = refArtists.child("restaurant").queryOrdered(byChild: "order")
        //ar.observe(DataEventType.value, with: { (snapshot) in
            ar.observeSingleEvent(of: .value, with: { (snapshot) in
                
            
            self.logoArray = []
            self.restkeAyrray = []
            self.rateArray = []
            self.Dic = [:]
            self.restName = []
            self.filteredData = []
            
            if snapshot.childrenCount > 0 {
                for restaurant in snapshot.children.allObjects as! [DataSnapshot] {
                   
                    //getting values
                    let restObject = restaurant.value as? [String: AnyObject]
                    let restkey = restaurant.key
                    self.restkeAyrray.append(restkey)
                    
                    print("restkeeeeeey\(restkey)")
                    UserDefaults.standard.set(self.restkeAyrray, forKey: "restkeAyrray")
                    
                   // let json = JSON(restObject)
                    let catRef  = Database.database().reference().child("restaurant/\(restkey)/category");
                    catRef.observeSingleEvent(of: .value, with: { (snapshot) in
                         let category = snapshot.value as? [String: String]
                        self.valueArray = []
                        for (key,value) in category! {
                            self.valueArray.append("\(value)")
                            self.Dic[restkey] = self.valueArray
                        }
    
                        print("DIC\(String(describing: self.Dic[restkey]))")
                        print("DICCOUNTTT\(self.Dic.count)")
                        UserDefaults.standard.set(self.Dic, forKey: "Dic")
                
                    })
//                    self.menuArray = []
//                    let Menuref = Database.database().reference().child("restaurant/\(restkey)");
//                    Menuref.observeSingleEvent(of: .value, with: { (snapshot) in
//                        if snapshot.hasChild("menu"){
//                            print("Trueeee menu exist")
////                            let Menuref2 = Database.database().reference().child("restaurant/\(restkey)/menu");
////                            Menuref.observe(DataEventType.value, with: { (snapshot) in
////                            let menu = snapshot.value as! [String : String]
////                            for (key,value) in menu {
////                                self.menuArray.append(value)
////                                print("LLLLL\(self.menuArray)")
////                                }})
//                            }
//
//                        else{
//
//                            print("false menu doesn't exist")
//                        }
//
//
//
//                    })
                    //////////////////
    
                    self.menuArray = []
                    //////////////////////
                    let Menuref = Database.database().reference().child("restaurant/\(restkey)");
                    Menuref.observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.hasChild("menu"){
                            print("Trueeee menu exist")
                            let Object = snapshot.childSnapshot(forPath: "menu")
                            let Menu = Object.value! as? [String:String]
                            for (key,value) in Menu! {
                                self.menuArray.append(value)
                            }
                        }
                        else{
                            
                            print("false menu doesn't exist")
                        }
                    })
                    let restNamee  = restObject?["name"] as! String
                    self.restName.append(restNamee)
                    UserDefaults.standard.set(self.restName, forKey: "restName")
                    self.filteredData = self.restName
                    let LOGO = restObject?["logo"] as! String
                    if (LOGO.first == "h")
                        {
                            print("LOGO\(LOGO)")
                            self.logoArray.append(LOGO)
                    }
                    else {
                         print("LOGO Nottt Exist")
                        self.logoArray.append("http://i66.tinypic.com/b99hl.jpg")
                    }
                    UserDefaults.standard.set(self.logoArray, forKey: "logoArray")
                    print("LOGOARAAAAAAAYCOUNT\(self.logoArray.count)")
                    self.ref3 = Database.database().reference().child("restaurant/\(restkey)/rate/total")
                    self.ref3.observeSingleEvent(of: .value, with: { (snapshot) in
                        let rate = snapshot.value  as! String
                        print("Rateeee\(rate))")
                        self.rateArray.append(rate)
                        UserDefaults.standard.set(self.rateArray, forKey: "rateArray")

                    })
                    //if let  restNamee = UserDefaults.standard.array(forKey: "restName")
                    //{
                   //     self.restName = restNamee as! [String]
                    
                    //}
                }
                
               /////////////////

            }
            self.tableview.reloadData()
            SVProgressHUD.dismiss()
        })
        

        
        if let  rateArrayy = UserDefaults.standard.array(forKey: "rateArray")
        {
            self.rateArray = rateArrayy as! [String]
            print("Rateeeeeeeeeeeee\(rateArray.count)")
        }
        
        if let  CategoryArraydefault = UserDefaults.standard.array(forKey: "CategoryArray")
        {
            CategoryArrayDefault = CategoryArraydefault as! [String]
        }
        if let  logoArrayy = UserDefaults.standard.array(forKey: "logoArray")
        {
            logoArray = logoArrayy as! [String]
       
        }
        if let  restkeAyrrayy = UserDefaults.standard.array(forKey: "restkeAyrray")
        {
            restkeAyrray = restkeAyrrayy as! [String]
        }
        
      
        
            print("NAMEEEEEEEE\(restName)")

        print("RESTKEEEEYARRaaay\(self.restkeAyrray)")
        print("RESTKEEEEYARRaaayCounttt\(self.restkeAyrray.count)")
        print("categoryArray\(CategoryArrayDefault)")
        print("COUNTTTTT\(CategoryArrayDefault.count)")
        print("RATEEEEEEE........................................\(rateArray.count)")
    }
    func categories(){
        ref = Database.database().reference()
        var ar = ref.child("category").queryOrderedByValue()
        ar.observeSingleEvent(of: .value, with: { (snapshot) in
            let category = snapshot.value as! [String:String]
                for (key,value) in category {
                self.Categories.append("\(key)")
            }
            
            print("Categorieeeees\(String(describing: self.Categories))")
           
            self.CategoryTableView.reloadData()
            
        })
    }

    func sponser(completion: @escaping () -> Void){
        slideImages = []
        sponsorNames = []
        typeArray = []
        sponserRef = Database.database().reference().child("sponsor");
        sponserRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.slideImages = []

                for Sponser in snapshot.children.allObjects as! [DataSnapshot] {
                    let sponserObject = Sponser.value as? [String: AnyObject]
                    let sponser = Sponser.key
                    print("Sponseeeer\(sponser)")
                    let Image  = sponserObject?["image"] as! String
                    print("Imageeeeee\(Image)")
                    self.slideImages.append(Image)
                    let restName  = sponserObject?["restaurant"] as! String
                    print("restName\(restName)")
                    self.sponsorNames.append(restName)
                    let type  = sponserObject?["type"] as! String
                    self.typeArray.append(type)
                    print("type\(type)")
                 
            }
                print("SSSSSSSSS\(self.slideImages)")
                UserDefaults.standard.set(self.slideImages, forKey: "slideImages")

            }
        })
        completion()

    }
    
    func branchFunc(){
     //   branchArray = []
       
    }
    
    @IBAction func filterResults(_ sender: Any) {
        CategoryTableView.isHidden = true
       
        filterResult.isHidden = true
        tableview.isHidden = false
        ImageSlideShow.isHidden = false
        if let selected = UserDefaults.standard.string(forKey: "SelectedCategory"){
            self.selectedCategory = selected
            print("Seleected\(self.selectedCategory)")
    }
    
    }
    func CALL(selected : String){
        self.branchArray = []
        
        let refbranch = Database.database().reference().child("restaurant/\(selected)/branch");
        refbranch.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                for branch in snapshot.children.allObjects as! [DataSnapshot] {

                    //getting values
                    let branchObject = branch.value as? [String: AnyObject]
                    let branchKey = branch.key
                    print("brachkeeeeeey\(branchKey)")
                    UserDefaults.standard.set(branchKey, forKey: "branchKeyDefault")
                    let details = Database.database().reference().child("restaurant/\(selected)/branch/\(branchKey)/details")
                    details.observeSingleEvent(of: .value, with: { (snapshot) in
                        let detail = snapshot.value as! String
                        print("DEtaaails\(detail)")
                        let Total = "\(branchKey), \(detail)"
                        print("TOTAAAAAAL\(Total)")
                        self.branchArray.append(Total)
                        print("Branch\(self.branchArray)")
                    })

                    self.TotalBranchAndPhone.append(branchKey)

                    let phone = Database.database().reference().child("restaurant/\(selected)/branch/\(branchKey)/phone")
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
                        self.mobileTableView.reloadData()

                    })

                }

            }

        })
    }
    @IBAction func mobileOkAction(_ sender: Any) {
        mobileTableView.isHidden = true
        mobileOk.isHidden = true
        tableview.isHidden = false
        CategoryTableView.isHidden = true
        filterResult.isHidden = true
        ImageSlideShow.isHidden = false
        Filter.isHidden = false
        filterImg.isHidden = false
    }
    @IBAction func FilterPressed(_ sender: Any) {
        CategoryTableView.isHidden = false
        print("Nottt Apppeaaaaar")
        self.navigationItem.leftBarButtonItem = nil
        filterResult.isHidden = false
        tableview.isHidden = true
        ImageSlideShow.isHidden = true
        Filter.isHidden = true
        filterImg.isHidden = true
        print("YYYYYYy")
    }
}
