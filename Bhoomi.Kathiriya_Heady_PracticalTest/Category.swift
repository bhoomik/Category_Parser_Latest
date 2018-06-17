//
//  Event.swift
//  Collecting_Arts
//
//  Created by Bhumi kathiria on 15/06/18.
//  Copyright © 2018 Bhumi kathiria. All rights reserved.
//

import Foundation


class Category
{
    
    var strCategoryTitle: String?

   // var isTaskSelected = false
    var strCateroyId: String?
    var arrProducts : NSMutableArray?
    var dictCategory : NSMutableDictionary?
    init(categoryTitle: String,  dictCategory: NSMutableDictionary ,arrProducts: NSMutableArray, categoryId: String)
    {
        self.strCategoryTitle = categoryTitle
        self.dictCategory = dictCategory
        self.strCateroyId = categoryId
        self.arrProducts = arrProducts
    }
    
}
