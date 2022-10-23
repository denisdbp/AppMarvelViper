//
//  CustomViews.swift
//  AppMarvelViper
//
//  Created by Admin on 12/10/22.
//

import Foundation
import UIKit

class CustomViews {
    static public func configConstraintEqualToView(object:UIView, uiView:UIView){
        NSLayoutConstraint.activate([
            object.topAnchor.constraint(equalTo: uiView.topAnchor),
            object.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            object.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            object.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
        ])
    }
}
