//
//  GetArticleProtocol.swift
//  E-Net
//
//  Created by Connor Meehan on 1/7/19.
//  Copyright © 2019 CBM Web Development. All rights reserved.
//

import Foundation
import UIKit

protocol GetArticleProtocol: class{
    func articleData(featuredImage: String, title: String, byLine: String, publishDate: String, excerpt: String, content: String)
}

class GetArticleModel: NSObject{
    weak var delegate : GetArticleProtocol!
    
    func getArticle(articleId: String){
        let requestURL = URL(string: "http://localhost/u/e-net/wp-json/e-net/v1/single/posts/id=" + articleId)
        var request = URLRequest(url: requestURL!)
        request.httpMethod = "GET" // set the method to GET
        
        // Create the task
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            // Kill if any errors
            if error != nil {
                return
            }
            
            // Handle the data
            self.parseJSON(data: data!)
        }
        
    }
    
    /**
    * Parse the JSON data to pass back to the protocol,
    * which will be used to populate the UI.
    */
    func parseJSON(data: Data){
        do{
            let jsonResults = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            
            if jsonResults == nil{
                return
            }
            
            if let result = jsonResults{                
                
                DispatchQueue.main.async {
                    
                    
                    if self.delegate != nil{
                        self.delegate.articleData(featuredImage: result["featured_media"] as! String, title: result["title"] as! String, byLine: result["author"]  as! String, publishDate: result["date"] as! String, excerpt: result["excerpt"] as! String, content: result["content"] as! String)
                    }
                }
            }
            
        }catch{
            DispatchQueue.main.async{
                self.delegate.articleData(featuredImage: String(), title: String(), byLine: String(), publishDate: String(), excerpt: String(), content: String())
            }
        }
    }
}
