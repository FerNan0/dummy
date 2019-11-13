//
//  PostListViewController.swift
//  dummy
//
//  Created by Fernando Duarte on 12/11/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class PostListViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tbvContent: UITableView!
    var interactor: PostListInteractor?
    var objDefault: ResponsePostDefault?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupUI() {
        tbvContent.delegate = self
        tbvContent.dataSource = self
        tbvContent.tableFooterView = UIView()
        self.tbvContent.register(UINib(nibName: "PostListCell", bundle: nil), forCellReuseIdentifier: "postListCell")
    }
    
    func reload() {
        self.tbvContent.reloadData()
    }
    
    func setup() {
        let viewController = self
        let presenter = PostListPresenter()
        let interactor = PostListInteractor()        
        viewController.interactor = interactor
        
        doRequestDefault(url: methodURLPost.post.rawValue)
    }
    
    func doRequestDefault(url: String) {
        interactor?.request(method: url, completion: { data in
            OperationQueue.main.addOperation {
                let decoder = JSONDecoder()
                do {
                    let customer = try decoder.decode(ResponsePostDefault.self, from: data)
                    self.objDefault = customer
                } catch {
                    print(error.localizedDescription)
                }
                self.reload()
            }
        })
    }
    
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objDefault?.dados?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postListCell") as? PostListCell
        let dados = self.objDefault?.dados![indexPath.row]
        cell?.interactor = (self.interactor!)
        cell?.selectionStyle = .none
        let urlImage = NSURL(string: dados!.image)
        var tags: String = ""
        
        for tag in dados!.tags {
            tags += " \(tag),"
        }
        tags.removeLast()
        cell?.configure(imgURL: urlImage! as URL, name: dados!.owner.firstName, lastName: dados!.owner.lastName, tags: tags, message: dados!.message)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil) as DetailViewController
        vc.id = objDefault?.dados![indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
