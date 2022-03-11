//
//  DetailVC.swift
//  #139
//
//  Created by Lan Ran on 2022/3/8.
//

import UIKit
import CoreData
import Kingfisher

class DetailVC: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
 
    var picName:String?
    var userData = [Personal]()
   
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if let picName = picName {
           getSpecItem(name: picName)
            name.text = userData[0].name
            phone.text = userData[0].phone
            email.text = userData[0].email
            guard let url = URL(string: userData[0].largePic!) else{return}
            image.kf.setImage(with: url)
        }
    }
   

}


extension DetailVC:DataPassDelegate{
    
    func passData(_ name: String) {
        
        picName = name
       
    }
    
    
    //CoreData
    func getSpecItem(name:String){
        let predicate = NSPredicate(format:"name == %@", name)
        let fetch :NSFetchRequest<Personal> = Personal.fetchRequest()
        fetch.predicate = predicate
        do{
            userData = try context.fetch(fetch)
        }
        catch{
            print(error)
        }
    }
}
