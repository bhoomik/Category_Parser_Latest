//
//  VariantVC.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class VariantVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var arrVariantList : NSMutableArray?
    
    var arrVariantModels : NSMutableArray? = NSMutableArray()
    
    let activityIndicator = ActivityIndicator()

    @IBOutlet weak var tblVariant : UITableView?
    
    @IBOutlet weak var lblNoVarint : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.commonInit()
        // Do any additional setup after loading the view.
    }
    
    func commonInit()
    {
        
        let nib = UINib(nibName: "VariantCell", bundle: nil)
        tblVariant?.register(nib, forCellReuseIdentifier: "VariantCell")
        
        self.title = "Variants"
        print("arrvarint in vc",self.arrVariantList)
        self.view.addSubview(self.activityIndicator)
        converToModelObjects {
            
            //do something here after running your function
            print("Tada!!!!")
            if(self.arrVariantModels?.count == 0)
            {
                self.lblNoVarint?.isHidden = false
            }
                
            else
            {
                self.lblNoVarint?.isHidden = true
            }
            self.activityIndicator.hide()
            self.tblVariant?.reloadData()
        }
        
    }

    func converToModelObjects(finished: () -> Void) {
        
        for (index, element) in (arrVariantList?.enumerated())!
        {
            let dictVariant = element as! NSDictionary
            
            
            let intVariantId = dictVariant.value(forKey: "id") as! Int
            let strVariantId = String(intVariantId)
            
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
         
      
            
            let intSize = dictVariant.value(forKey: "size") as! NSNumber
            let strSize = String(describing: intSize)
            
           
            let intPrice = dictVariant.value(forKey: "price") as! NSNumber
            let strPrice = String(describing: intPrice)
            
            let objVariant : Variant = Variant(strVarid: strVariantId, dictVariant:dictVariant.mutableCopy() as! NSMutableDictionary, strColor: dictVariant.value(forKey: "color") as! String, strSize: strSize, strPrice: strPrice )
            
            self.arrVariantModels?.add(objVariant)
            
            
            
            
        }
        
        finished()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrVariantList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : VariantCell = tableView.dequeueReusableCell(withIdentifier: "VariantCell", for: indexPath) as! VariantCell
        
        cell.lblColor?.text = "Test"
       let objVariant : Variant  = arrVariantModels?.object(at: indexPath.row) as! Variant
        
        cell.lblColor?.text =   String(format: "Color : %@",objVariant.strColor!)
        cell.lblSize?.text =   String(format: "Size : %@",objVariant.strSize!)
        cell.lblPrice?.text =   String(format: "Color : %@",objVariant.strPrice!)
        
     //   let objRank : Ranking  = arrRanking?.object(at: indexPath.row) as! Ranking
       // cell.accessoryType = .disclosureIndicator
       // cell.textLabel?.text = objRank.strRankTitle
        return cell
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
