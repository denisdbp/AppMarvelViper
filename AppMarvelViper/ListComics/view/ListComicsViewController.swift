//
//  ViewController.swift
//  AppMarvelViper
//
//  Created by Admin on 11/10/22.
//

import UIKit

protocol ViewProtocol:AnyObject {
    var presenter:PresenterProtocol? {get set}
    func updateTableViewSuccess()
    func updateErrorFetchRequest()
}

class ListComicsViewController: UIViewController, ViewProtocol {
    
    var listComicsView:ListComicsView?
    
    var presenter: PresenterProtocol?
    
    func updateTableViewSuccess() {
        self.listComicsView?.listComicsTableView.reloadData()
        self.listComicsView?.indicatorView.stopAnimating()
        self.listComicsView?.listComicsTableView.tableFooterView = self.listComicsView?.footerView
    }
    
    func updateErrorFetchRequest() {
        self.alert(title: "Erro ao carregar os daddos", message: "Deseja tentar novamente ?", titleButton: "Recarregar") { _ in
            self.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.limitCount = 20
        self.presenter?.fetchRequestApi(fetchRequestApi: true)
        self.listComicsView?.configProtocols(delegate: self, datasource: self)
        self.listComicsView?.delegate = self
    }
    
    override func loadView(){
        super.loadView()
        self.listComicsView = ListComicsView()
        self.view = self.listComicsView
    }
    
    private func reloadData(){
        self.listComicsView?.indicatorView.startAnimating()
        self.presenter?.fetchRequestApi(fetchRequestApi: true)
        self.updateTableViewSuccess()
    }
    
    private func alert(title:String, message:String, titleButton:String, handler:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: titleButton, style: .default, handler: handler)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListComicsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.listModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListComicsTableViewCell.identifier, for: indexPath) as? ListComicsTableViewCell
        if let model = self.presenter?.listModel[indexPath.row] {
            self.listComicsView?.indicatorView.startAnimating()
            cell?.getImageComics(model: model, success: {imageComic in
                cell?.listComicTableViewCellView.imageComic.image = UIImage(data: imageComic)
                self.listComicsView?.indicatorView.stopAnimating()
            })
            cell?.listComicTableViewCellView.nameComic.text = model.name
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let description = self.presenter?.listModel[indexPath.row].description {
            if description.isEmpty {
                self.alert(title: "Dados do personagem", message: "Personagem sem descrição", titleButton: "Ok", handler: nil)
            }else {
                self.alert(title: "Dados do personagem", message: description, titleButton: "Ok", handler: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ListComicsViewController:ListComicsViewProtocol {
    func moreButton() {
        self.presenter?.limitCount += 20
        self.presenter?.fetchRequestApi(fetchRequestApi: true)
    }
}
