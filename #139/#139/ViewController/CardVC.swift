//
//  CardVC.swift
//  #139
//
//  Created by Lan Ran on 2022/3/8.
//
//                                              __----~~~~~~~~~~~------___
//                                  .  .   ~~//====......          __--~ ~~
//                   -.            \_|//     |||\\  ~~~~~~::::... /~
//                 ___-==_       _-~o~  \/    |||  \\            _/~~-
//         __---~~~.==~||\=_    -_--~/_-~|-   |\\   \\        _/~
//     _-~~     .=~    |  \\-_    '-~7  /-   /  ||    \      /
//   .~       .~       |   \\ -_    /  /-   /   ||      \   /
//  /  ____  /         |     \\ ~-_/  /|- _/   .||       \ /
//  |~~    ~~|--~~~~--_ \     ~==-/   | \~--===~~        .\
//           '         ~-|      /|    |-~\~~       __--~~
//                       |-~~-_/ |    |   ~\_   _-~            /\
//                            /  \     \__   \/~                \__
//                        _--~ _/ | .-~~____--~-/                  ~~==.
//                       ((->/~   '.|||' -_|    ~~-/ ,              . _||
//                                  -_     ~\      ~~---l__i__i__i--~~_/
//                                  _-~-__   ~)  \--______________--~~
//                                //.-~~~-~_--~- |-------~~~~~~~~
//                                       //.-~~~--\)
//  神龍噴火 永無Bug
    

import UIKit
import Kingfisher
import CollectionViewPagingLayout
import CoreData

class CardVC: UIViewController {

   
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    let content = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let layout = CollectionViewPagingLayout()
    var userData : UserDataResopse?  {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        
    }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadData()
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        layout.numberOfVisibleItems = nil
    }
    
    
    
    
    func downloadPic(image:UIImageView,indexPath:Int){
        if let userData = userData {
            let url = URL(string: userData.results[indexPath].picture.large)
            image.kf.setImage(with: url)
        }
    
    }
    
   
    @IBAction func tapLike(_ sender: UIButton) {
        if let userData = userData {
            addItem(name: userData.results[layout.currentPage].name.first,
                    phone: userData.results[layout.currentPage].cell ,
                    Email: userData.results[layout.currentPage].email ,
                    gender: userData.results[layout.currentPage].gender ,
                    pic: userData.results[layout.currentPage].picture.large )
            print("Successful")
            print(layout.currentPage)
        }
        layout.goToNextPage()
    }
    @IBAction func tapUnLike(_ sender: UIButton) {
     
    
    }
    
}


extension CardVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! CollectionViewCell
        downloadPic(image: cell.imageView, indexPath: indexPath.row)
        cell.BGView.layer.cornerRadius = 20
        cell.imageView.layer.cornerRadius = 20
        cell.name.text = userData?.results[indexPath.row].name.first
        return cell
    }
    
    
    
    
    
}

extension CardVC{
    func downloadData(){
        let url = "https://randomuser.me/api/?results=10" //索要1筆資料
        let decoder = JSONDecoder()
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data { //得到的資料在這邊
                    do{
                        let userDatas = try decoder.decode(UserDataResopse.self, from: data)
                        self.userData = userDatas
                    }
                    catch{
                        print(error)
                    }
                }
                
            }.resume()
            
        }
       
    }
    
}



//CoreData
extension CardVC{
    
    func addItem(name:String,phone:String,Email:String,gender:String,pic:String){
        let newItems = Personal(context: content)
        newItems.name = name
        newItems.phone = phone
        newItems.email = Email
        newItems.gender = gender
        newItems.largePic = pic
        
        do{
            try  content.save()
        }
        catch{
            print(error)
        }
        
    }
    
    
    
}
