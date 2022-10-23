//
//  ListComicsPresenter.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import Foundation

protocol PresenterProtocol:AnyObject {
    var interactor:InteractorProtocol? {get set}
    var view:ViewProtocol? {get set}
    var listModel:[ListModel] {get set}
    var router:RouterProtocol? {get set}
    var limitCount:Int {get set}
    func fetchRequestSuccess(model:[ListModel])
    func fetchRequestError(error:Error)
    func fetchRequestApi(fetchRequestApi: Bool)
}

class ListComicsPresenter:PresenterProtocol {
    var router: RouterProtocol?
    
    var listModel: [ListModel] = []
    
    var interactor: InteractorProtocol?
    
    var view: ViewProtocol?
    
    var limitCount:Int = 0
    
    func fetchRequestSuccess(model: [ListModel]) {
        self.listModel = model
        self.view?.updateTableViewSuccess()
    }
    
    func fetchRequestError(error: Error) {
        self.view?.updateErrorFetchRequest()
    }
    
    func fetchRequestApi(fetchRequestApi: Bool) {
        if fetchRequestApi {
            self.interactor?.getComics(limit: self.limitCount)
        }
    }
}
