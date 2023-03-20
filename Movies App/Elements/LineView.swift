//
//  LineView.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class LineView: UIView{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LineView{
    func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "bl")
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 2)])
    }
}

