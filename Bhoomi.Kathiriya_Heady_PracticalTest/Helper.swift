//
//  Helper.swift
//  Collecting_Arts
//
//  Created by Bhumi kathiria on 14/06/18.
//  Copyright © 2018 Bhumi kathiria. All rights reserved.
//

import Foundation


public class Helper
{
    
    
    func checkIntenetConnection() -> Bool
    {
        if Reachability.isConnectedToNetwork()
        {
            print("Internet Connection Available!")
            return true
        }
        else
        {
            
            return false
            print("Internet Connection not Available!")
        }
        
    }
    
    
    
    
}
