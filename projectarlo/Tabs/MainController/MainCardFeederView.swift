//
//  MainCardFeederView.swift
//  projectarlo
//
//  Created by Charlie Arcodia on 11/28/22.
//

import Foundation
import UIKit


class MainCardFeederView : UIView {
    
    var mainController : MainController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = coreLightColor
        self.addViews()
        
    }
    
    func addViews() {
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
