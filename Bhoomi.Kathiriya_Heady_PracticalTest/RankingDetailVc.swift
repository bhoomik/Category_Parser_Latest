//
//  RankingDetailVc.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class RankingDetailVc: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var arrRankingList : NSMutableArray?
    
    var arrVariantModels : NSMutableArray? = NSMutableArray()
    
    let activityIndicator = ActivityIndicator()
    var appDelegate : AppDelegate?
    
    @IBOutlet weak var tblRankDetail : UITableView?
    
    @IBOutlet weak var lblDetail : UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

    func commonInit()
    {
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate

        let nib = UINib(nibName: "RankDetailCell", bundle: nil)
        tblRankDetail?.register(nib, forCellReuseIdentifier: "RankDetailCell")
        
        self.title = "Rank Details"
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrRankingList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : RankDetailCell = tableView.dequeueReusableCell(withIdentifier: "RankDetailCell", for: indexPath) as! RankDetailCell
        
        var dictRank : NSDictionary = arrRankingList?.object(at: indexPath.row) as! NSDictionary
        
        
        print("dictrank is",dictRank)
        
        let intId = dictRank.value(forKey: "id") as! Int
        let strId = String(describing: intId)
        
       // let filteredArray = self.appDelegate?.arrAllProducts.filter { $0["id"] == strId }
       // print("filter resule",filteredArray)
    
        print("id is",strId)
        var bPredicate: NSPredicate = NSPredicate(format: "id == %d", intId)
        print("app del is",self.appDelegate?.arrAllProducts)
        
        let filteredArray : NSArray? = self.appDelegate?.arrAllProducts?.filtered(using: bPredicate) as! NSArray
        
        
        print("HERE ", filteredArray?.count)
        
        if((filteredArray?.count)! > 0)
        {
            var dictMath : NSDictionary? = filteredArray?.object(at: 0) as! NSDictionary
            
            cell.lblName?.text =  String(format: "Name: %@",dictMath?.value(forKey: "name") as! CVarArg)
            
        }
       // if let value = (objAsset.dictAsset?.value(forKey: "titleImageId") as? String)

     //   if let cunt = (dictRank.value(forKey: "view_count") as! NSNumber)
    if let value = (dictRank.value(forKey: "view_count") as? NSNumber)

        {
        let intViewCount = dictRank.value(forKey: "view_count") as! NSNumber
        let strViewCount = String(describing: intViewCount)
        
        cell.lblViewCount?.text =  String(format: "View Count: %@",strViewCount)
        }
        
        if let value = (dictRank.value(forKey: "order_count") as? NSNumber)
            
        {
            let intViewCount = dictRank.value(forKey: "order_count") as! NSNumber
            let strViewCount = String(describing: intViewCount)
            
            cell.lblViewCount?.text =  String(format: "Order Count: %@",strViewCount)
        }
        
        if let value = (dictRank.value(forKey: "shares") as? NSNumber)
            
        {
            let intViewCount = dictRank.value(forKey: "shares") as! NSNumber
            let strViewCount = String(describing: intViewCount)
            
            cell.lblViewCount?.text =  String(format: "Shares: %@",strViewCount)
        }
       // let objRank : Ranking  = arrRanking?.object(at: indexPath.row) as! Ranking
        return cell
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
