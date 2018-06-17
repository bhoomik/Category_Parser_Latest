//
//  RankingVC.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class RankingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let activityIndicator = ActivityIndicator()
    @IBOutlet weak var tblRanking : UITableView?
    @IBOutlet weak var lblNoRanking : UILabel?
    var arrRanking : NSMutableArray? = NSMutableArray()
    var selRankDetail : Int?
  //  var arrAllProducts : NSMutableArray? = NSMutableArray()
    
    
      var appDelegate : AppDelegate?
    var arrProductList : NSMutableArray? = NSMutableArray()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

    func commonInit()
    {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate

        self.tblRanking?.tableFooterView = UIView()
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.hide()
        self.loadDataFromServer()
    }
    
    func loadDataFromServer()
    {
        
        
        
        let objHelper : Helper = Helper()
        
        
        if(objHelper.checkIntenetConnection() == true)
        {
            
            self.activityIndicator.show()
            
            let strURL = String(format: "%@/json/",kBaseURL)
            
            
            print("load more method url",strURL)
            
            
            //  self.createRequest(qMes: "", strURL: "http://api.pluto/v1/apirouter/asset/list/0/10/CreatedDate/desc", method: "GET") { (output) in
            
            //  AddEventAPIParser.createRequest(<#T##AddEventAPIParser#>)
            
            
            let objEventParser : AddEventAPIParser = AddEventAPIParser()
            
            objEventParser.createRequest(qMes: "", strURL: strURL, method: "GET", completionBlock: { (output)   in
                // your failure handle
                let dictResponse = output as NSDictionary
                
                print("dict output",dictResponse)
                var arrTemp : NSMutableArray?  = NSMutableArray()
                
                arrTemp    = dictResponse.value(forKey: "rankings") as? NSMutableArray
                print("arr all ranking",arrTemp?.count ?? Int())
                
                
                self.arrProductList    = dictResponse.value(forKey: "categories") as? NSMutableArray
                
                self.converToModelObjects {
                    
                    print("arr appdel product",self.appDelegate?.arrAllProducts)
                }
//                print("arr all ranking",arrCategories?.count ?? Int())
//
//                for (index, element) in (arrTemp?.enumerated())!
//                {
//                    let dictRank = element as! NSDictionary
                
                
                
                for (index, element) in (arrTemp?.enumerated())!
                {
                    let dictRank = element as! NSDictionary
                    
                    let arrProduct = dictRank.value(forKey: "products") as! NSArray
                    
                 //   let intCatId = dictCatory.value(forKey: "id") as! Int
                   // let strCategoryId = String(intCatId)
                    
                    
                    
                    let objRank : Ranking = Ranking(rankTitle: dictRank.value(forKey: "ranking") as! String, dictRank:dictRank.mutableCopy() as! NSMutableDictionary, arrProducts: arrProduct.mutableCopy() as! NSMutableArray )
                    
                    self.arrRanking?.add(objRank)
                    
                    
                }
                
                DispatchQueue.main.async { () -> Void in
                    
                    self.activityIndicator.hide()
                    if(arrTemp?.count == 0)
                    {
                         self.lblNoRanking?.isHidden = false
                    }
                    else
                    {
                        self.lblNoRanking?.isHidden = true
                    }
                    self.tblRanking?.reloadData()
                }
            }, andFailureBlock:   { (failure) -> Void in
                
                
                DispatchQueue.main.async { () -> Void in
                    self.activityIndicator.hide()
                    
                      self.lblNoRanking?.isHidden = false
                    
                      self.tblRanking?.reloadData()
                }
            })
            
        }
        else
        {
            self.displayNoInternetAlert()
            return
            
        }
    }
    
        
        func converToModelObjects(finished: () -> Void) {
            var arrProductMerge: [[String: AnyObject]] = [[String: AnyObject]]()

            print("arrproduct list",arrProductList)
            
            for (index, element) in (arrProductList?.enumerated())!
            {
                let dictProduct = element as! NSDictionary
                
               
                
                /* let formatter = DateFormatter()
                 // initially set the format based on your datepicker date / server String
                 formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                 
                 let myString = formatter.string(from: dictProduct.value(forKey: "date_added") as! Date) // string purpose I add here
                 // convert your string to date
                 let yourDate = formatter.date(from: myString)
                 //then again set the date format whhich type of output you need
                 formatter.dateFormat = "dd-MMM-yyyy"
                 // again convert your date to string
                 let myStringafd = formatter.string(from: yourDate!)
                 
                 print(myStringafd)*/
              
//                print("arr sub product is",dictProduct.value(forKey: "products") as? [String:AnyObject])
//                 if let arrP = dictProduct.value(forKey: "products") as? [String:AnyObject]
//                 {
//
//                   arrProductMerge.append(arrP)
//                    print("arr product merge count",arrProductMerge.count)
//
//                }
                var arrSubProduct : NSArray = dictProduct.value(forKey: "products") as! NSArray
                for (index, element) in (arrSubProduct.enumerated())
                {
                    var dictProduct =  element as!  NSDictionary
                    self.appDelegate?.arrAllProducts?.add(dictProduct)
                    
                }
                
                
                //self.arrProductModels?.add(objProduct)
                
                
                
                
            }
            
            finished()
            
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrRanking?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
         let objRank : Ranking  = arrRanking?.object(at: indexPath.row) as! Ranking
         cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = objRank.strRankTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selRankDetail = indexPath.row
        // appDelegate?.arrSelPredefinedTasks?.removeAllObjects()
        self.performSegue(withIdentifier: "RankToDetail", sender: self)
        
        
    }
    
    //MARK: Segeue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "RankToDetail"
        {
            var vcRankDetail : RankingDetailVc =  segue.destination as! RankingDetailVc
         
            
            let objRank : Ranking  = arrRanking?.object(at: self.selRankDetail!) as! Ranking
            
            //var arrSubCategory : NSArray  = objCategory.dictCategory?.value(forKey: "child_categories") as! NSArray
            
             vcRankDetail.arrRankingList = NSMutableArray()
            vcRankDetail.arrRankingList  = objRank.arrProducts
            // vcProudct.arrSubCategories  = arrSubCategory.mutableCopy() as! NSMutableArray
            //vcProudct.arrProductList =  objCategory.arrProducts
            
            
        }
    }
    
    // MARK: Other Utility Methods
    func displayNoInternetAlert()
    {
        
        let alert = UIAlertController(title: "", message: kCheckInternetConnection, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
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
