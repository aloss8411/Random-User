//
//  RandomVC.swift
//  #139
//
//  Created by Lan Ran on 2021/10/4.
//

import UIKit
import CoreData
import MapKit






class RandomVC: UIViewController{
    
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var map: MKMapView!
    var a:normalData?
    var bigPic:UIImage?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        runCircle()
        fetchData()
        
        
    }
    
    func fetchData()  {
        if let url = URL(string: "https://randomuser.me/api/"){
            URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    do{
                        
                        let test = try decoder.decode(allData.self, from: data)
                        let user = test.results[0]
                        let imageused = try! Data(contentsOf: user.picture.thumbnail)
                        let imageBig = try! Data(contentsOf: user.picture.large)
                        self.a = user
                        DispatchQueue.main.async {

                            self.name.text = user.name.first
                            self.lastname.text = user.name.last
                            self.email.text = user.email
                            self.photo.image = UIImage(data: imageused)
                            self.bigPic = UIImage(data: imageBig)
                            //處理照片問題
                            //地圖顯示
                            let location = CLLocation(latitude: Double(user.location.coordinates.latitude)!, longitude: Double(user.location.coordinates.longitude)!)
                            let dos = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                            self.map.setRegion(dos, animated: true)
                            }
                        }
                    catch{
                        print(error)
                    }
                }
            }.resume()
        }
    }

    
    func runCircle(){
        photo.frame = CGRect(x: 40, y: 40, width: 100, height: 100)
        photo.contentMode = .scaleAspectFit
        photo.layer.masksToBounds = true
        photo.layer.cornerRadius = photo.frame.width / 2.5
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let controller = segue.destination as? DetailVC
            controller?.b = a
            controller?.c = bigPic
        }
      
        
        
    }
    

    
}

