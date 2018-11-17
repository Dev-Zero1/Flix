//
//  superheroVC.swift
//  Flix
//
//  Created by XCodeClub on 2018-11-16.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import AlamofireImage
class superheroVC: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchNowPlaying()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! posterCell
        let movie = movies[indexPath.item]
        if  let posterPathString = movie["poster_path"] as? String{
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + posterPathString)!
        cell.posterIMGView.af_setImage(withURL: posterURL)
        
        }
        return cell
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
                    self.collectionView.reloadData()
                    
                    //self.refreshControl.endRefreshing()
                    
                }
            }
            //switch(error){
            //}
        }
        task.resume()
    }
    
    
    
}
