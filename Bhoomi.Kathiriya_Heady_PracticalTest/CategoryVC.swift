//
//  CategoryVC.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    

    
    @IBOutlet weak var tblCategories : UITableView?
    @IBOutlet weak var lblNoCateogories : UILabel?
    var selCategoryIndex : Int?
    let activityIndicator = ActivityIndicator()
    var arrAllCategories : NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }

     func commonInit()
     {
        
        self.view.addSubview(activityIndicator)
        self.tblCategories?.tableFooterView = UIView()
        self.title = "Categories"
        self.activityIndicator.hide()
        self.loadDataFromServer()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Retrieve data from server method
    
    
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
                
                arrTemp    = dictResponse.value(forKey: "categories") as? NSMutableArray
                print("arr all assets",arrTemp?.count ?? Int())
                
            
                
                
                for (index, element) in (arrTemp?.enumerated())!
                {
                    let dictCatory = element as! NSDictionary
                    
                    let arrProduct = dictCatory.value(forKey: "products") as! NSArray
                    
                    let intCatId = dictCatory.value(forKey: "id") as! Int
                    let strCategoryId = String(intCatId)
                    
                    
                    
                    let objCategory : Category = Category(categoryTitle: dictCatory.value(forKey: "name") as! String, dictCategory:dictCatory.mutableCopy() as! NSMutableDictionary, arrProducts: arrProduct.mutableCopy() as! NSMutableArray, categoryId: strCategoryId as! String )
                    
                    self.arrAllCategories?.add(objCategory)
                    
                    
                }
          
                DispatchQueue.main.async { () -> Void in
                    
                    self.activityIndicator.hide()
                    if(arrTemp?.count == 0)
                    {
                        self.lblNoCateogories?.isHidden = false
                    }
                    else
                    {
                        self.lblNoCateogories?.isHidden = true
                    }
                    self.tblCategories?.reloadData()
                }
            }, andFailureBlock:   { (failure) -> Void in
                
                if let httpResponse = failure as? HTTPURLResponse
                {
                    if (httpResponse.statusCode == 401)
                    {
                        print("unautorized")
                        
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "UserToken")
                        self.activityIndicator.show()
                        
                    }
                    
                }
                DispatchQueue.main.async { () -> Void in
                    self.activityIndicator.hide()
                    
                    self.lblNoCateogories?.isHidden = false
                    
                    self.tblCategories?.reloadData()
                }
            })
            
        }
        else
        {
            self.displayNoInternetAlert()
            return
            
        }
    }
    
    //MARK : UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrAllCategories?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let objCategory : Category  = arrAllCategories?.object(at: indexPath.row) as! Category
         cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = objCategory.strCategoryTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selCategoryIndex = indexPath.row
        // appDelegate?.arrSelPredefinedTasks?.removeAllObjects()
        self.performSegue(withIdentifier: "CategoryToProduct", sender: self)
        
        
    }
    
    //MARK: Segeue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CategoryToProduct"
        {
            var vcProudct : ProductListVC =  segue.destination as! ProductListVC
            let objCategory : Category  = arrAllCategories?.object(at: self.selCategoryIndex!) as! Category
            
            var arrSubCategory : NSArray  = objCategory.dictCategory?.value(forKey: "child_categories") as! NSArray
            
            
            vcProudct.arrProductList = NSMutableArray()
            vcProudct.arrSubCategories  = NSMutableArray()
            vcProudct.arrSubCategories  = arrSubCategory.mutableCopy() as! NSMutableArray
              vcProudct.arrProductList =  objCategory.arrProducts
            
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
