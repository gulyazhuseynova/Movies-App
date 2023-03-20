//
//  SearchVC.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit

class SearchVC: UIViewController {
    private var tap = UITapGestureRecognizer()
    private var vm = MovieManagerVM()
    private var searchDataList : [Results2?] = []
    
    //Elements from blueprints
    private let lineView = LineView()
    private let searchTextField = SearchTextField()
    private let searchButton = SearchButton()
    
    private var tableView : UITableView = {
    
        let table = UITableView(frame: .zero)
        table.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        
        return table
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
        setBindings()
        dismissKeyboard()
        
    }
    func dismissKeyboard(){
        tap = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func viewDidTapped(){
        searchTextField.endEditing(true)
    }
    
    private func setBindings() {
        vm.success3 = {item in
            DispatchQueue.main.async {
                
                self.searchDataList = []
                self.searchDataList.append(contentsOf: item?.results ?? [])
                print("table ",self.searchDataList.count)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUpView(){
        
        view.backgroundColor = UIColor(named: "bckgrnd")
        title = "Search"
        
        
        view.addSubview(lineView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        
        searchButton.addTarget(self, action: #selector(didTapSearchButton) , for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            searchButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            lineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }


}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        if let data = searchDataList[indexPath.row]{
            
            cell.movieNameLabel.text = data.original_title
            if let rate = data.vote_average{
                cell.ratingLabel.text = "\(rate)"
                
            }else{
                cell.ratingLabel.text = "---"
            }
            cell.dateLabel.text = data.release_date
            var genreLabelText = ""
            
            if data.genre_ids.count == 0{
                genreLabelText = "---"
            }else{
                genreLabelText = ""
                for id in data.genre_ids{
                    genreLabelText += genreIdDict[id ?? 0] ?? ""
                    genreLabelText += "  "
                    print("abc",genreLabelText)
                }
            }
            
            
           
            cell.genreLabel.text = genreLabelText
            cell.durationLabel.text = "139 minutes"
 
            cell.posterImage.kf.setImage(with: URL(string: (imageBaseURL + (data.poster_path ?? ""))))
            
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedId = searchDataList[indexPath.row]?.id // Assuming the id is the same as the row index
        
        // Create a new instance of the detail view controller
        let detailVC = DetailVC()
        
        // Set the id property of the detail view controller
        detailVC.idRecieved = selectedId
        
        // Push the detail view controller onto the navigation stack
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    
    
}
//MARK: - Text Field
extension SearchVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text != "" {
            self.vm.SearchTitleRequest(searchText: textField.text!)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
    }
    
    @objc func didTapSearchButton(){
        searchTextField.endEditing(true)
    }
}

