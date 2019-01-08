//
//  Article Controller.swift
//  E-Net
//
//  Created by Connor Meehan on 1/7/19.
//  Copyright © 2019 CBM Web Development. All rights reserved.
//

import UIKit

class ArticleController: UIViewController, GetArticleProtocol{
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var featuredImage : UIImageView!
    @IBOutlet weak var articleTitle : UILabel!
    @IBOutlet weak var byLine : UILabel!
    @IBOutlet weak var publishDate : UILabel!
    @IBOutlet weak var excerpt : UILabel!
    @IBOutlet weak var content : UILabel!
    
    var articleId = String()
    
    func articleData(featuredImage: String, title: String, byLine: String, publishDate: String, excerpt: String, content: String) {
        
        if featuredImage != ""{ // Check if the image exists before trying to fetch it
            let url = URL(string: featuredImage)
            let data = try? Data(contentsOf: url!)
            self.featuredImage.image = UIImage(data: data!)
        }
        
        // Set the rest of the article content
        self.articleTitle.text = title
        self.byLine.text = byLine
        self.publishDate.text = publishDate
        self.excerpt.text = excerpt
        self.content.text = content
        
        // Stop the activity indicator. 
        activityIndicator.stopAnimating()
    }
    
    
    override func loadView(){
        super.loadView()
        activityIndicator.startAnimating()
        
        let articleModel = GetArticleModel()
        articleModel.delegate = self
        articleModel.getArticle(articleId: articleId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
