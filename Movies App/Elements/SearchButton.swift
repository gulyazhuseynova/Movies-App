//
//  SearchButton.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 17.03.23.
//

import UIKit

class SearchButton: UIButton{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchButton{
    func setupUI(){
    
        translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        
        setImage(image, for: .normal)
        tintColor = .lightGray
    }
    
    func setupConstraints(){
//        NSLayoutConstraint.activate([])
    }
}

    
