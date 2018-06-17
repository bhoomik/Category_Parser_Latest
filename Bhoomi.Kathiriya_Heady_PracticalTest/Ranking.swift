//
//  Ranking.swift
//  Bhoomi.Kathiriya_Heady_PracticalTest
//
//  Created by Bhoomi Kathiriya on 17/06/18.
//  Copyright © 2018 Bhoomi Kathiriya. All rights reserved.
//

import Foundation
class Ranking
{
    
    var strRankTitle: String?
    
    // var isTaskSelected = false
    var arrProducts : NSMutableArray?
    var dictRank : NSMutableDictionary?
    init(rankTitle: String,  dictRank: NSMutableDictionary ,arrProducts: NSMutableArray)
    {
        self.strRankTitle = rankTitle
        self.dictRank = dictRank
        self.arrProducts = arrProducts
    }
    
}
