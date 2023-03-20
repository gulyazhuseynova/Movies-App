//
//  SearchTextField.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class SearchTextField: UITextField{
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchTextField{
    func setupUI(){
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = UIColor(named: "gry")
        
        textColor = .white
        
        font =  UIFont.systemFont(ofSize: 15, weight: .regular)
        
        attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
    func setupConstraints(){
        setLeftPaddingPoints(15)
        setRightPaddingPoints(15)
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalToConstant: 50)])
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
