//
//  AddEventAPIParser.swift
//  Collecting_Arts
//
//  Created by Bhumi kathiria on 05/06/18.
//  Copyright © 2018 Bhumi kathiria. All rights reserved.
//

import Foundation
import UIKit

class AddEventAPIParser
{

    
    var appDelegate : AppDelegate?
    
    public func createRequest(qMes: String, strURL: String, method: String , completionBlock: @escaping ([String: AnyObject]) -> Void,andFailureBlock failBlock: @escaping ((AnyObject) -> Void)) -> Void
    {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        
        let requestURL = URL(string: strURL)
        var request = URLRequest(url: requestURL!)
        
        request.httpMethod = method
        
        
        var str  = ""
        
        
    /*    var tokenDict : NSMutableDictionary = NSMutableDictionary()
            
        
        if(UserDefaults.standard.object(forKey: "UserToken") != nil)
        {
            
         tokenDict   = UserDefaults.standard.object(forKey: "UserToken") as! NSMutableDictionary

        }
        if(tokenDict.value(forKey: "token") != nil)
        {
        
        
        str = NSString(format:"bearer %@",tokenDict.value(forKey: "token") as! CVarArg) as String
        
        print("str header is",str)
        
        }
        else
        {
          
            
        }*/
        
      //  request.addValue(str as! String, forHTTPHeaderField: "Authorization")
        
       // request.addValue(str as! String, forHTTPHeaderField: "Authorization")
        
        
        request.httpBody = qMes.data(using: .utf8)
        
        let requestTask = URLSession.shared.dataTask(with: request)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            
            if let httpResponse = response as? HTTPURLResponse
            {
                print("status code is",httpResponse.statusCode)
                
                if (httpResponse.statusCode == 401)
                {
                    failBlock(httpResponse as AnyObject)
                    
                }
                
            }
            
            /* if(error != nil) {
             print("Error: \(error)")
             }else
             {
             
             
             let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
             //send this block to required place
             completionBlock(outputStr!);
             }*/
            
            if (error == nil)
            {
            
            do {
                //create json object from data
              //  if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                    
                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? AnyObject
                {
                    
                    print("retrieved json is",json)
                    
                    if let value = json as?  NSDictionary
                    {
                        
                        print("object is dict",json)
                        
                    }
                    
                    if json is Dictionary<AnyHashable,Any>
                    {
                        
                        var jsonResponse = json as! [String: AnyObject]
                        
                        print("Yes, it's a Dictionary")
                        var dictResponse = json as! NSDictionary
                        
                        print("dict response",dictResponse)
                          completionBlock(jsonResponse);
                        
                    }
                    if let array = json as? NSArray
                    {
                        
                        print("object is arrays",array)
                    }
                    
                  /*  if let array = json as? NSArray
                    {
                        
                        print("object is",array)
                        
                        var jsonResponse = json as! NSArray
                        print("responsse array is",jsonResponse)
                        completionBlock(jsonResponse)
                        
                    }*/
                  
                    // handle json...
                }
                
            } catch let error
            {
                print("parsing error is",error.localizedDescription)
                failBlock(error as AnyObject)
            }
            }
            else
            {
                print("parsing error auto is",error?.localizedDescription)
                failBlock(error as AnyObject)
                
                
            }
        }
        requestTask.resume()
    }
    
    
    
    
    
    public func createRequestReturnsArray(qMes: String, strURL: String, method: String , completionBlock: @escaping (NSArray) -> Void,andFailureBlock failBlock: @escaping ((AnyObject) -> Void)) -> Void
    {
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        
        
        let requestURL = URL(string: strURL)
        var request = URLRequest(url: requestURL!)
        
        request.httpMethod = method
        
        
        var str  = ""
        
        var tokenDict : NSMutableDictionary = NSMutableDictionary()
            
    
        if(UserDefaults.standard.object(forKey: "UserToken") != nil)
        {
            
            
            tokenDict =   UserDefaults.standard.object(forKey: "UserToken") as! NSMutableDictionary

            str = NSString(format:"bearer %@",tokenDict.value(forKey: "token") as! CVarArg) as String
            
            print("str header is",str)
            
        }
        else
        {
            
            
        }
        //  request.addValue(str as! String, forHTTPHeaderField: "Authorization")
        
        request.addValue(str as! String, forHTTPHeaderField: "Authorization")
        
        
        request.httpBody = qMes.data(using: .utf8)
        
        let requestTask = URLSession.shared.dataTask(with: request)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let httpResponse = response as? HTTPURLResponse
            {
                print("status code is",httpResponse.statusCode)
                
                if (httpResponse.statusCode == 401)
                {
                 failBlock(httpResponse as AnyObject)
                    
                }
                
            }
            /* if(error != nil) {
             print("Error: \(error)")
             }else
             {
             
             
             let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String!
             //send this block to required place
             completionBlock(outputStr!);
             }*/
             print("error array is",error.debugDescription)
             print("data is",data)
            
            
            if(error  == nil)
            {
            do {
                //create json object from data
                //  if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: AnyObject]
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? AnyObject
                {
                    
                   
                    print("retrieved json is",json)
                    
                    
                    
                    if json is Dictionary<AnyHashable,Any>
                    {
                        
                        var jsonResponse = json as! [String: AnyObject]
                        
                        print("Yes, it's a Dictionary")
                        var dictResponse = json as! NSDictionary
                        
                        print("dict response",dictResponse)
                    //    print("parsing error is",error.localizedDescription)
                    
                        failBlock(error as AnyObject)
                        //completionBlock(jsonResponse);
                        
                    }
                    
                    if let array = json as? NSArray
                    {
                        
                        print("object is",array)
                        
                        var jsonResponse = json as! NSArray
                      //  print("responsse array is",jsonResponse)
                        completionBlock(jsonResponse)
                        
                    }
                    
                    // handle json...
                }
                
            } catch let error
            {
                
                print("parsing error is",error)
                
                print("parsing error is",error.localizedDescription)
                
                failBlock(error as AnyObject)
            }
            }
            else
            {
                print("2parsing error is",error?.localizedDescription)
                failBlock(error as AnyObject)
            }
        }
        requestTask.resume()
    }
    
    
    
    
    
}
