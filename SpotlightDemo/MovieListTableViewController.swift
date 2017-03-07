//
//  MovieListTableViewController.swift
//  SpotlightDemo
//
//  Created by 阮巧华 on 2017/3/6.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

import UIKit
import Kingfisher
import CoreSpotlight
import MobileCoreServices

class MovieListTableViewController: UITableViewController {

    let list:[(Dictionary<String, String>)] = NSArray(contentsOfFile: Bundle.main.path(forResource: "movie", ofType: "plist")!) as! [(Dictionary<String, String>)]
    var images = [Data]()
    var selectItem = Dictionary<String, String>()
    var imagesCount:Int = 0 {
        didSet {
            if imagesCount == list.count {
                setupSearchableContent()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in list {
            let imageUrl:String = item["imageUrl"]!
            KingfisherManager.shared.retrieveImage(with: URL(string:imageUrl)!, options: nil, progressBlock: nil, completionHandler: { [weak self](image, error, cacheType, imageURL) -> () in
                self?.images.append(UIImagePNGRepresentation(image!)!)
                self?.imagesCount += 1
            })
        }
    }

    func setupSearchableContent() {
        var searchableItems = [CSSearchableItem]()
        
        for index in 0..<list.count {
            let item = list[index]
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
            searchableItemAttributeSet.title = item["name"]!
            // 设置电影封面.
            searchableItemAttributeSet.thumbnailData = images[index]
            // 设置简介.
            searchableItemAttributeSet.contentDescription = item["text"]!
            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.SpotIt.\(index)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
            searchableItems.append(searchableItem)
        }
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
            print(error ?? "")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MovieListTableViewCell
        let dic = list[indexPath.row]
        let imageUrl = dic["imageUrl"]
        let name = dic["name"]
        let text = dic["text"]
        let url = URL(string: imageUrl!)
        cell.mImageView.kf.setImage(with: url)
        cell.mTitle.text = name
        cell.mDetailTextLabel.text = text
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem = list[indexPath.item]
        performSegue(withIdentifier: "MovieDetailViewController", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MovieDetailViewController") {
            let VC:MovieDetailViewController =  segue.destination as! MovieDetailViewController
            let url:URL = URL(string: selectItem["href"]!)!
            VC.webUrl = url
        }
    }

}
