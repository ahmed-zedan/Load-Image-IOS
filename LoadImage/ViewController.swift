//
//  ViewController.swift
//  LoadImage
//
//  Created by Zedan on 5/28/20.
//  Copyright © 2020 Zedan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage(from: "https://s3-eu-west-1.amazonaws.com/opensooq-read/wp-content/uploads/2020/01/26151852/%D9%86%D8%B8%D8%A7%D9%85-ios-990x556.jpg")
        
        setImage(from: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSOTcK5z1bIb43ly7bX71gegDQMNbVbTMXcrUTmug2KAC40fJxy&usqp=CAU")
    }
    
    // MARK: - First Way
    /*
     First Way To load Image #Hard Way# and better way
     */
    private func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()){
        let session = URLSession.shared
        if let urlImage = URL(string: urlString){
            let dataTask = session.dataTask(with: urlImage) { (data, response, error) in
                if error != nil{
                    completionHandler(nil)
                }else{
                    completionHandler(data)
                }
            }
            dataTask.resume()
        }else{
            completionHandler(nil)
        }
        
    }
    

    private func loadImage(from urlString: String){
        fetchImage(from: urlString) { (data) in
            if data != nil{
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }else{
                print("error to load Image!")
            }
        }
    }
    
    // MARK: - Second Way
    // easy Way
    func setImage(from urlString: String){
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.secondImageView.image = UIImage(data: imageData)
            }
        }
    }


}

