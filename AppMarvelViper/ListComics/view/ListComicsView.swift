//
//  ListComicsView.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import UIKit

protocol ListComicsViewProtocol {
    func moreButton()
}

class ListComicsView: UIView {
    
    public var delegate:ListComicsViewProtocol?
    
    lazy var indicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .red
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var listComicsTableView:UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(ListComicsTableViewCell.self, forCellReuseIdentifier: ListComicsTableViewCell.identifier)
        return tableView
    }()
    
    let footerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    
    lazy var moreButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mais...", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(self.tappedMoreButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubViews()
        CustomViews.configConstraintEqualToView(object: self.listComicsTableView, uiView: self)
        self.configConstraintIndicator()
        self.configConstraintMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedMoreButton(){
        self.delegate?.moreButton()
    }
    
    private func addSubViews(){
        self.addSubview(self.listComicsTableView)
        self.addSubview(self.indicatorView)
        self.footerView.backgroundColor = .black
        self.footerView.addSubview(self.moreButton)
    }
    
    public func configProtocols(delegate:UITableViewDelegate, datasource:UITableViewDataSource){
        self.listComicsTableView.delegate = delegate
        self.listComicsTableView.dataSource = datasource
    }
    
    private func configConstraintIndicator(){
        NSLayoutConstraint.activate([
            self.indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configConstraintMoreButton(){
        NSLayoutConstraint.activate([
            self.moreButton.centerXAnchor.constraint(equalTo: self.footerView.centerXAnchor),
            self.moreButton.centerYAnchor.constraint(equalTo: self.footerView.centerYAnchor),
            self.moreButton.widthAnchor.constraint(equalToConstant: 100),
            self.moreButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
