//
//  DetailCell.swift
//  dummy
//
//  Created by Fernando Duarte on 13/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView! {
        didSet {
            imgView?.layer.cornerRadius = 30.0            
        }
    }
    @IBOutlet weak var lblName: UILabel! {
       didSet {
           
       }
    }
    @IBOutlet weak var lblTime: UILabel! {
       didSet {
           
       }
    }
    @IBOutlet weak var lblMessage: UILabel! {
       didSet {
           
       }
    }
    var interactor: DatailInteractor?
    
    func configure(imgURL:URL,name:String,lastName:String,message:String) {
        interactor?.downloadImage(from: imgURL, completion: { img in
            OperationQueue.main.addOperation {
                self.imgView?.image = img
                self.lblName.text = "\(name) \(lastName)"
                self.lblMessage.text = message
                self.lblTime.text = "a few seconds ago"
            }
        })
    }
}
