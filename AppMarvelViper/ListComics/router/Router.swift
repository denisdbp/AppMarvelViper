//
//  Router.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import Foundation

protocol RouterProtocol:AnyObject {
    static func start()->Any
}

class Router:RouterProtocol {
    static func start()->Any {
        let view:ViewProtocol = ListComicsViewController()
        let presenter:PresenterProtocol = ListComicsPresenter()
        let interactor:InteractorProtocol = ListComicsInteractor()
        typealias viewController = ViewProtocol & ListComicsViewController
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = Router()
        return view as! viewController
    }
}
