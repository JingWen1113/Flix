//
//  MoviesViewController.swift
//  Flix
//
//  Created by Jing Wen on 2/8/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //here created an array of dictionaries
    var movies = [[String:Any]] ()  // Key: string , value: can be any type of variables

    override func viewDidLoad() {
        super.viewDidLoad()
        //******************* step 3
        tableView.dataSource = self
        tableView.delegate = self
        
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
            
            self.tableView.reloadData()
            
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
    //******************
    //asking for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell" ) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        //check API for the string name, this one is overview
        let synopsis = movie["overview"] as! String
        
        //cell.textLabel!.text = title
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL (string: baseUrl + posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print("loading up the details screen" )
        //need to do 2functions on this function:
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
    
        //Pass the selected movie to the details view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
}
}
