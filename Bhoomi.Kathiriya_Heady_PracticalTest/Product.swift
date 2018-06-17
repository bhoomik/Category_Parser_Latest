//
//  Product.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation

class Product
{
    
    var strProductTitle: String?
    
    // var isTaskSelected = false
    var strProductId: String?
    var strDate: String?
    var strTaxName: String?
    var strTaxValue: String?

    var arrVariants : NSMutableArray?
    var dictProduct : NSMutableDictionary?
    init(productTitle: String,  dictProduct: NSMutableDictionary ,arrVariants: NSMutableArray, productId: String,dateAdded:String,taxName:String,taxValue:String)
    {
        self.strProductTitle = productTitle
        self.dictProduct = dictProduct
        self.strProductId = productId
        self.arrVariants = arrVariants
        self.strDate = dateAdded
        self.strTaxName = taxName
        self.strTaxValue = taxValue
        
    }
    
}
