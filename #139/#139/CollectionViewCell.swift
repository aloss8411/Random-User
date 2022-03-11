//
//  CollectionViewCell.swift
//  #139
//
//  Created by Lan Ran on 2022/3/9.
//

import UIKit
import CollectionViewPagingLayout

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var name: UILabel!
    
    
    override class func awakeFromNib() {
       
    }
    
   
    
   
    
}



extension CollectionViewCell:StackTransformView{
    var stackOptions: StackTransformViewOptions {
        .layout(.transparent)
    }
    
}
