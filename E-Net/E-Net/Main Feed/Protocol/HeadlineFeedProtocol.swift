//
//  HeadlineFeed.swift
//  E-Net
//
//  Created by Connor Meehan on 1/7/19.
//  Copyright © 2019 CBM Web Development. All rights reserved.
//

import Foundation

protocol GetHeadlinesFeedProtocol: class{
    func getHeadlinesArticles(articleId: Array<String>, imageUrls: Array<String>, headlines: Array<String>)
}

class GetHeadlinesArticles: NSObject{
    weak var delegate: GetHeadlinesFeedProtocol!
    
    func getHeadlines(){
        let requestUrl = URL(string: "http://localhost/u/e-net/wp-json/e-net/v1/posts/headlines")
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil{
                return
            }
            
            self.parseJson(data: data!)
        }
    }
    
    func parseJson(data: Data){
        do{
            let jsonResults = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSArray
            
            if jsonResults == nil{
                return
            }
            
            var id: Array<String> = Array()
            var imageUrl: Array<String> = Array()
            var headline: Array<String> = Array()
            
            if let results = jsonResults{
                for i in 0..<(results.count){
                    let result = results[i] as! NSDictionary
                    
                    id.append(result["post_id"] as! String)
                    imageUrl.append(result["featured_image"] as! String)
                    headline.append(result["headline"] as! String)
                    
                    DispatchQueue.main.async{
                        if self.delegate != nil{
                            self.delegate.getHeadlinesArticles(articleId: id, imageUrls: imageUrl, headlines: headline)
                        }
                    }
                }
            }
        }catch{
            
        }
    }
}
