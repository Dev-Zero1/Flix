//
//  detailVC.swift
//  Flix
//
//  Created by XCodeClub on 2018-11-16.
//  Copyright © 2018 administrator. All rights reserved.
//

import UIKit
import AlamofireImage
enum MovieKeys{
  static let title = "title"
    //doesn't seem more efficient!
}
class detailVC: UIViewController {

    @IBOutlet weak var posterIMG:    UIImageView!
    @IBOutlet weak var backdropIMG:  UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var movie: [String:Any]?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
         titleLabel.text = movie["title"] as? String
         releaseLabel.text = movie["release_date"] as? String
         detailsLabel.text = movie["overview"] as? String
         
        let backdropPathString   = movie["backdrop_path"] as! String
        let posterPathString   = movie["poster_path"] as! String
        let imgBaseURL = "https://image.tmdb.org/t/p/w500"
        let backdropURL = URL(string: imgBaseURL+backdropPathString)!
        let posterURL = URL(string: imgBaseURL+posterPathString)!
            
        backdropIMG.af_setImage(withURL: backdropURL)
        posterIMG.af_setImage(withURL: posterURL)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
