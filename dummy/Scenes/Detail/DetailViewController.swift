//
//  DetailViewController.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tbvContent: UITableView!
    var interactor: DatailInteractor?
    var dados: ResponsePostDetail?
    var id: Int64?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    func setupUI() {
        tbvContent.delegate = self
        tbvContent.dataSource = self
        tbvContent.tableFooterView = UIView()
        self.tbvContent.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        if (id != nil) {
            let urlWithId = methodURLDetail.postDetail.rawValue.replacingOccurrences(of: "{postId}", with: "\(id ?? -1)")
            doRequestDetail(url: urlWithId)
        }
    }
    
    func setup() {
        let viewController = self
        let presenter = DetailPresenter()
        let interactor = DatailInteractor()
        
        viewController.interactor = interactor
    }
    
    func reload(){
        tbvContent.reloadData()
    }
    
    func doRequestDetail(url: String) {
        interactor?.request(method: url, completion: { objDetail in
            OperationQueue.main.addOperation {
               let decoder = JSONDecoder()
               do {
                   let detail = try decoder.decode(ResponsePostDetail.self, from: objDetail)
                   print(detail)
                   self.dados = detail
               } catch {
                   print(error.localizedDescription)
               }
               self.reload()
            }
        })
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dados?.dados?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell
        let dados = self.dados?.dados![indexPath.row]
        cell?.interactor = (self.interactor!)
        cell?.selectionStyle = .none
        let urlImage = NSURL(string: dados!.owner.image)
        
        cell?.configure(imgURL: urlImage! as URL, name: dados!.owner.firstName, lastName: dados!.owner.lastName, message: dados!.message)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
