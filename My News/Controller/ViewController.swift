//
//  ViewController.swift
//  My News
//
//  Created by Amin faruq on 14/08/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbViewBerita: UITableView!
    var newsModel: [News] = []
    let NEWS_URL =  "https://newsapi.org/v2/top-headlines?country=id&category=entertainment&apiKey=45edc79fad7c497f957b65c3a95d605f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBerita(url: NEWS_URL)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
    }
    
    func fetchBerita(url : String){
        SVProgressHUD.show()
        Alamofire.request(url).responseJSON { (response) in
            SVProgressHUD.dismiss()
            let newsJSON : JSON = JSON(response.result.value!)
            self.updateNews(json: newsJSON)
        }
    }
    
    func updateNews(json : JSON){
        for articleJSON in 0 ..< json["articles"].count{
            
            let news = News()
            
            let title = json["articles"][articleJSON]["title"].string
            let newsDescription = json["articles"][articleJSON]["description"].string
            let imgURL = json["articles"][articleJSON]["urlToImage"].string
            let url = json["articles"][articleJSON]["url"].string
            
            news.url = url
            news.judul = title
            news.deskripsi = newsDescription
            news.imgUrl = imgURL
            
            self.newsModel.append(news)
        }
        self.tbViewBerita.reloadData()
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellNews", for: indexPath) as! NewsCell
        
        cell.lbTitle.text = self.newsModel[indexPath.item].judul
        cell.lbDescription.text = self.newsModel[indexPath.item].deskripsi
        cell.imgNews.downloadImage(from: (self.newsModel[indexPath.item].imgUrl)!)
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let story = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let toNewsDetail = story.instantiateViewController(withIdentifier: "newsDetail") as! DetailViewController
        
        toNewsDetail.urlWeb = self.newsModel[indexPath.item].url
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        show(toNewsDetail, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

extension UIImageView {
    func downloadImage(from url : String){
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}

