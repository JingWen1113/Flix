//
//  MoviesViewController.swift
//  Flix
//
//  Created by Jing Wen on 2/8/21.
//

import UIKit

class MoviesViewController: UIViewController {
    //here created an array of dictionaries
    var movies = [[String:Any]] ()  // Key: string , value: can be any type of variables

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //this below chunk of codes download the array of movies and store in the variable movies
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data { //fetch data back, will provide in dataDictionary variable
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
            
            //casting?
            self.movies = dataDictionary ["results"] as! [[String:Any]]
                //print the dataDictionary
            print(dataDictionary)
            //we want the list of movies to show up instead of the results, we need to store it in the view controller so we can access later to show in that table view
            //create a variable , an array of dictionaries
            
            
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
