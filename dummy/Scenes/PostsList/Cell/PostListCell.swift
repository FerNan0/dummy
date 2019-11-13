//
//  PostListCell.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class PostListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            
        }
    }
    @IBOutlet weak var lblName: UILabel! {
       didSet {
           
       }
    }
    @IBOutlet weak var lblTags: UILabel! {
       didSet {
           
       }
    }
    @IBOutlet weak var lblMessage: UILabel! {
       didSet {
           
       }
    }
    var interactor: PostListInteractor?
    
    func configure(imgURL:URL,name:String,lastName:String,tags:String,message:String) {            
        interactor?.downloadImage(from: imgURL, completion: { img in
            OperationQueue.main.addOperation {
                self.imgView?.image = img
                self.lblName.text = "\(name) \(lastName)"
                self.lblTags.text = tags
                self.lblMessage.text = message
            }
        })
    }
}
