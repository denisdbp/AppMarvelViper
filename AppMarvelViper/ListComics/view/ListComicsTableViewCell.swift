//
//  ListComicsTableViewCell.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import UIKit

class ListComicsTableViewCell: UITableViewCell {
    
    static public let identifier:String = "ListComicsTableViewCell"
    
    lazy var listComicTableViewCellView:ListComicsTableViewCellView = {
        let view = ListComicsTableViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubViews()
        CustomViews.configConstraintEqualToView(object: self.listComicTableViewCellView, uiView: self.contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews(){
        self.contentView.addSubview(self.listComicTableViewCellView)
    }
    
    public func getImageComics(model:ListModel, success:@escaping(_ imageComic:Data)->()){
        guard let urlImage = URL(string:"\(model.thumbnail.path).\(model.thumbnail.extensionThumbnail)") else {return}
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: urlImage)
                DispatchQueue.main.async {
                    success(data)
                }
                
            }catch {
                
            }
        }
    }
}
