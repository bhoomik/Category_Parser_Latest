//
//  MainVC.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class MainVC: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    @IBOutlet weak var tblListing: UITableView?
    let activityIndicator = ActivityIndicator()
    var arrAllCategories : NSMutableArray? = NSMutableArray()
    var arrLisitng: NSMutableArray? = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrLisitng?.add("Categories")
         self.arrLisitng?.add("Rankings")
        
        // Do any additional setup after loading the view.
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrLisitng?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
       // let objCategory : Category  = arrAllCategories?.object(at: indexPath.row) as! Category
        cell.accessoryType = .disclosureIndicator
     //   cell.accessoryType = .detailButton
        cell.textLabel?.text = arrLisitng?.object(at: indexPath.row) as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //self.selCategoryIndex = indexPath.row
        // appDelegate?.arrSelPredefinedTasks?.removeAllObjects()
        
        if(indexPath.row == 0)
        {
        self.performSegue(withIdentifier: "MainToCategory", sender: self)
        }
        else
        {
            
            self.performSegue(withIdentifier: "MainToRanking", sender: self)
            
            
        }
        
        
    }
    
    
   
    //MARK: Segeue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "MainToCategory"
        {
           // var vcProudct : ProductListVC =  segue.destination as! ProductListVC
           // let objCategory : Category  = arrAllCategories?.object(at: self.selCategoryIndex!) as! Category
            
           // vcProudct.arrProductList = NSMutableArray()
          //  vcProudct.arrProductList =  objCategory.arrProducts
            
            
        }
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
