//
//  DetailVC.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 17.03.23.
//

import UIKit

class DetailVC: UIViewController {
    
    var idRecieved: Int?
    private var vm = MovieManagerVM()
    private var movieDetail : GetByIdData?
    private var posterImage = UIImageView()
    private var headingLabel = UILabel()
    private var overviewLabel = UILabel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "bckgrnd")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        setBindings()
        if let id = idRecieved{
            self.vm.getIdRequest(id: String(id))
        }
        
        setUpView()
  
    }
    private func setUpView(){
        
        view.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 15
        posterImage.contentMode = .scaleAspectFit
        
        view.addSubview(headingLabel)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.textColor = .white
        headingLabel.numberOfLines = 0
        headingLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        
        view.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            
            headingLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            overviewLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            
        ])
        
        
        
    }
    
    
    private func setBindings() {
        vm.success4 = {item in
            DispatchQueue.main.async {
                self.movieDetail = item
                self.setUpData()
                
            }
        }
    }
    
    private func setUpData(){
        if let data = movieDetail{
            self.posterImage.kf.setImage(with: URL(string: (imageBaseURL + (data.poster_path ?? "") )))
            self.headingLabel.text = data.original_title
            self.overviewLabel.text = data.overview
        }
        
    }
    
    
}
