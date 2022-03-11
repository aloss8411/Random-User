//
//  ListVC.swift
//
//
//
//

import UIKit
import CoreData
import Kingfisher

protocol DataPassDelegate{
    func passData(_ name:String)
}

class ListVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    
    var passData:DataPassDelegate?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest:NSFetchRequest<Personal> = Personal.fetchRequest() //專門搜尋Personal的資料
    
    var userData = [Personal]()
    var selectName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItem()
        tableView.reloadData() 
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        tableView.reloadData()
    }
    
    func downloadPic(image:UIImageView,indexPath:Int){
        
            let url = URL(string: userData[indexPath].largePic!)
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url)
        
        
    }

}

extension ListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! TableViewCell
        cell.name.text = userData[indexPath.row].name
        cell.phone.text = userData[indexPath.row].phone
        downloadPic(image: cell.imageViews, indexPath: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectName = userData[indexPath.row].name
        self.passData?.passData(selectName!)
        let VC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        VC.picName = selectName
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .coverVertical
        present(VC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteItem(number: indexPath.row)
            getAllItem()
            tableView.reloadData()
        }
    }
}

extension ListVC{
    func getAllItem(){
        
            do{
                userData = try context.fetch(Personal.fetchRequest())
            }
            catch{
                print(error)
            }
        }
    func deleteItem(number:Int){
        context.delete(userData[number])
        do{
           try context.save()
        }
        catch{
            print(error)
        }
        
    }
}

