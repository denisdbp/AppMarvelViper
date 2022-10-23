//
//  ListComicsTableViewCellView.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import UIKit

class ListComicsTableViewCellView: UIView {
    
    lazy var imageComic:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    lazy var nameComic:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.addSubViews()
        self.configConstraintsImageComic()
        self.configConstraintsNameComic()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews(){
        self.addSubview(self.imageComic)
        self.addSubview(self.nameComic)
    }
    
    private func configConstraintsImageComic(){
        NSLayoutConstraint.activate([
            self.imageComic.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.imageComic.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.imageComic.widthAnchor.constraint(equalToConstant: 150),
            self.imageComic.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configConstraintsNameComic(){
        NSLayoutConstraint.activate([
            self.nameComic.leadingAnchor.constraint(equalTo: self.imageComic.trailingAnchor, constant: 10),
            self.nameComic.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
