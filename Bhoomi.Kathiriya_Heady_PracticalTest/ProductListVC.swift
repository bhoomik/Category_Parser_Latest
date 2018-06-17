//
//  ProductListVC.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    
    var arrProductList : NSMutableArray?
    
    var arrProductModels : NSMutableArray? = NSMutableArray()
    var arrSubCategories: NSMutableArray?
    var selProudctIndex : Int?
    @IBOutlet weak var tblProducts : UITableView?
    
      @IBOutlet weak var viewChildCate : UIView?
    
    @IBOutlet weak var lblChildCat : UILabel?
    
    @IBOutlet weak var lblNoProducts : UILabel?
    let activityIndicator = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.commonInit()
        print("arr in product vc",arrProductList)
        
        // Do any additional setup after loading the view.
    }

    
    func commonInit()
    {
        
        self.title =  "Products"
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tblProducts?.register(nib, forCellReuseIdentifier: "ProductCell")
        tblProducts?.tableFooterView = UIView()
        arrProductModels = NSMutableArray()
        self.activityIndicator.show()
        print("arr sub cat",arrSubCategories)
        
        
        
        
        if((arrSubCategories?.count)! > 0)
        {
            
            self.viewChildCate?.isHidden = false
        tblProducts?.tableHeaderView = self.viewChildCate
        
            let strSubCategory = arrSubCategories?.componentsJoined(by: ",")
        
            lblChildCat?.text  =  String(format: "Child Categories : %@",strSubCategory!)
        
        }
        else
        {
            self.viewChildCate?.isHidden = false
            tblProducts?.tableHeaderView = self.viewChildCate
            
          //  let strSubCategory = arrSubCategories?.componentsJoined(by: ",")
            
            lblChildCat?.text  = "No Child Categories."
            
        }
        converToModelObjects {
            
            //do something here after running your function
            print("Tada!!!!")
            if(self.arrProductList?.count == 0)
            {
                self.lblNoProducts?.isHidden = false
            }
                
            else
            {
                self.lblNoProducts?.isHidden = true
            }
            self.activityIndicator.hide()
            self.tblProducts?.reloadData()
        }
        
    
    }
    
    
    func converToModelObjects(finished: () -> Void) {
        
        for (index, element) in (arrProductList?.enumerated())!
        {
            let dictProduct = element as! NSDictionary
            
            let arrVariant = dictProduct.value(forKey: "variants") as! NSArray
            
            let intProductId = dictProduct.value(forKey: "id") as! Int
            let strProductId = String(intProductId)
            
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
            var strDateTime : String  = dictProduct.value(forKey: "date_added") as! String
            
            let arrDate = strDateTime.components(separatedBy: "T")
            
            var strDate : String = arrDate[0]
            var dictTax = dictProduct.value(forKey: "tax") as! NSDictionary
            print("strdate is",strDate)
            
            let intTaxVal = dictTax.value(forKey: "value") as! NSNumber
            let strTaxVal = String(describing: intTaxVal)
            
            print("tax value",strTaxVal)
            
            let objProduct : Product = Product(productTitle: dictProduct.value(forKey: "name") as! String, dictProduct:dictProduct.mutableCopy() as! NSMutableDictionary, arrVariants: arrVariant.mutableCopy() as! NSMutableArray, productId: strProductId, dateAdded: strDate, taxName: dictTax.value(forKey: "name") as! String, taxValue:  strTaxVal )
            
            self.arrProductModels?.add(objProduct)
           
            
            
            
        }
        
        finished()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrProductModels?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let objProduct : Product  = arrProductModels?.object(at: indexPath.row) as! Product
         cell.accessoryType = .disclosureIndicator
        cell.lblTitle?.text = objProduct.strProductTitle
        cell.lblDateAdded?.text  =  String(format: "Date Added: %@",objProduct.strDate!)
        cell.lblTax?.text  =  String(format: "%@ : %@",objProduct.strTaxName!, objProduct.strTaxValue!)
        
        
       // let strURL = String(format: "%@/json/",kBaseURL)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selProudctIndex = indexPath.row
        // appDelegate?.arrSelPredefinedTasks?.removeAllObjects()
        self.performSegue(withIdentifier: "ProductToVatiant", sender: self)
        
        
    }
    
    //MARK: Segeue Method
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ProductToVatiant"
        {
            var vcVariant : VariantVC =  segue.destination as! VariantVC
            let obProduct : Product  = arrProductModels?.object(at: self.selProudctIndex!) as! Product
            
           //var arrSubCategory : NSArray  = objCategory.dictCategory?.value(forKey: "child_categories") as! NSArray
            
            
            vcVariant.arrVariantList = NSMutableArray()
            vcVariant.arrVariantList  = obProduct.arrVariants
          // vcProudct.arrSubCategories  = arrSubCategory.mutableCopy() as! NSMutableArray
           //vcProudct.arrProductList =  objCategory.arrProducts
            
            
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
