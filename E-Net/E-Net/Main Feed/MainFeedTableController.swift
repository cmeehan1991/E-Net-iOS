//
//  MainFeedTableController.swift
//  E-Net
//
//  Created by Connor Meehan on 1/7/19.
//  Copyright © 2019 CBM Web Development. All rights reserved.
//

import UIKit
import SDWebImage

class MainFeedTableController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetHeadlinesFeedProtocol{
    
    var articleId : Array<String> = Array(), imageUrls : Array<String> = Array(), headlines : Array<String> = Array()
    
    func getHeadlinesArticles(articleId: Array<String>, imageUrls: Array<String>, headlines: Array<String>) {
        self.articleId = articleId
        self.imageUrls = imageUrls
        self.headlines = headlines
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! MainFeedTableViewCellController
        cell.headline?.text = headlines[indexPath.row]
        let imageUrl = self.imageUrls[indexPath.row]
        
        cell.featuredImage?.image = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
    
    override func loadView(){
        super.loadView()
    }
}
