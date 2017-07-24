//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        exerciseOne()
        exerciseTwo()
        exerciseThree()
        */
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above, by contacting iTunes via Alamofire and downloading the data as a JSON file
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    let randomJSON = Int(arc4random_uniform(25))
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
                    
                    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
                        print("Could not find iTunes-Movies.json!")
                        return
                    }
                    
                    
                    let jsonData = try! Data(contentsOf: jsonURL)
                    
                    // Enter SwiftyJSON!
                    // moviesData now contains a JSON object representing all the data in the JSON file.
                    // This JSON file contains the same data as the tutorial example.
                    let moviesData = JSON(data: jsonData)
                    
                    // We've done you the favor of grabbing an array of JSON objects representing each movie
                    let allMoviesData = moviesData["feed"]["entry"].arrayValue
                    
                    let i = allMoviesData[randomJSON]
                    let movies = Movie(json: i)



                    self.loadPoster(urlString: movies.poster)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    func loadPoster(urlString: String) {
        posterImageView.af_setImage(withURL: URL(string: urlString)!)
    }
        
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
           }
}

