//
//  Variant.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation
class Variant
{
    
    var strVarid: String?
    var strColor: String?
    
    var strSize: String?
    
    var strPrice: String?
    
    
    // var isTaskSelected = false
   
    var dictVariant : NSMutableDictionary?
    init(strVarid: String,  dictVariant: NSMutableDictionary ,strColor: String,strSize: String,strPrice: String)
    {
        self.strSize = strSize
        self.dictVariant = dictVariant
        self.strVarid = strVarid
        self.strColor = strColor
        self.strPrice = strPrice
    }
    
}
