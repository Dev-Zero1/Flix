//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by administrator on 11/9/18.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    var movies:[[String:Any]]  = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview( refreshControl, at: 0)
        tableView.dataSource = self
       tableView.addSubview(activityIndicator)
        fetchNowPlaying()
        
   
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
    activityIndicator.startAnimating()
    activityIndicator.isHidden = false
    activityIndicator.hidesWhenStopped = true
    fetchNowPlaying()
    
    self.activityIndicator.stopAnimating()
    
    }
    func fetchNowPlaying(){
    
        // let key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        // let url = URL(string: "\(key)")!
    
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request){( data, response, error) in
    if let error = error {
    print(error.localizedDescription)
    }else if let data = data {
    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    let movies = dataDictionary["results"] as! [[String : Any]]
    for movie in movies {
    let title = movie["title"] as! String
        
    self.movies = movies
    self.tableView.reloadData()
    
    self.refreshControl.endRefreshing()
    
    }
    }
    //switch(error){
    //}
    }
    task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie       =   movies[indexPath.row]
        let title       =   movie["title"] as! String
        let overview    =   movie["overview"] as! String
        let imgStr      =   movie["poster_path"] as! String
        
        cell.titleLabel.text = title
        cell.overLabel.text = overview
        
        let imgBaseURL = "https://image.tmdb.org/t/p/w500"
        let imgURL = URL(string: imgBaseURL+imgStr)
        cell.img.af_setImage(withURL: imgURL!)
        return cell
    }
}

