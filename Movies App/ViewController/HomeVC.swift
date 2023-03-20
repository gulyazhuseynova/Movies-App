//
//  ViewController.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit
import Kingfisher

class HomeVC: UIViewController {
    
    private var vm = MovieManagerVM()
    private var topFiveList : [Results?] = []
    private var categoryDataList : [Results?] = []
    
    //Elements from blueprints
    private let lineView = LineView()
    private let searchTextField = SearchTextField()
    private let searchButton = SearchButton()
    
    //Elements newly created
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let collectionView1 : UICollectionView = {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 210)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(UINib(nibName: "TopFiveCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopFiveCollectionViewCell")
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let collectionView2 : UICollectionView = {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 50)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let collectionView3 : UICollectionView = {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.scrollDirection = .vertical
        
        DispatchQueue.main.async {
            layout.itemSize = CGSize(width: collection.frame.width/3.2, height: collection.frame.height/2.4)
        }
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        collection.register(UINib(nibName: "MoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        collection.backgroundColor = .clear
        return collection
    }()
    

    
    private var headingLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "What do you want to watch?"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setUpView()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView3.delegate = self
        collectionView3.dataSource = self
        
        setBindings()
        vm.getRequest(type: CategoryType.topRated.rawValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.vm.getRequest(type: CategoryType.nowPlaying.rawValue)
        }
        
        goToSearch()
    }
    
    func goToSearch(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToSearchTapped))
        searchTextField.addGestureRecognizer(tap)
    }
    @objc func goToSearchTapped(){
        guard let tabBarController = self.tabBarController else { return }
        tabBarController.selectedIndex = 1
    }
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        
        let constraint = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true
       

        
    }
    
    
    func setUpView(){
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(named: "bckgrnd")
        title = "Home"
        
        
        contentView.addSubview(headingLabel)
        contentView.addSubview(searchTextField)
        contentView.addSubview(searchButton)
        contentView.addSubview(collectionView1)
        contentView.addSubview(collectionView2)
        contentView.addSubview(collectionView3)
        view.addSubview(lineView)
        

        //Constraints
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            headingLabel.heightAnchor.constraint(equalToConstant: 20),

            
            searchTextField.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            searchButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            
            collectionView1.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collectionView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView1.heightAnchor.constraint(equalToConstant: 220),
            
            collectionView2.topAnchor.constraint(equalTo: collectionView1.bottomAnchor, constant: 20),
            collectionView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            collectionView2.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView3.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: 0),
            collectionView3.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            collectionView3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            collectionView3.heightAnchor.constraint(equalToConstant: 300),
            collectionView3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            lineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            lineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
        ])
    }
    
    private func setBindings() {
        vm.success = {item in
            DispatchQueue.main.async {
                print("aa", item?.results.count ?? 0)
                self.topFiveList.append(contentsOf: item?.results ?? [])
                self.collectionView1.reloadData()
            }
        }
        vm.success2 = {item in
            DispatchQueue.main.async {
                self.categoryDataList = []
                print("bb", item?.results.count ?? 0)
                self.categoryDataList.append(contentsOf: item?.results ?? [])
                self.collectionView3.reloadData()
            }
        }
        

    }


}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case collectionView1:
            return topFiveList.count
            
        case collectionView2:
            return categoryNameList.count
            
        case collectionView3:
            return categoryDataList.count
            
        default:
            fatalError()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case collectionView1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopFiveCollectionViewCell", for: indexPath) as! TopFiveCollectionViewCell
            let data = topFiveList[indexPath.row]
            
            if let url = data?.poster_path{
                cell.topFiveImage.kf.setImage(with: URL(string: (imageBaseURL + url)))
            }
            
            cell.topNumberLabel.text = String(indexPath.row + 1)
            
            return cell
            
        case collectionView2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        
            
            let item = categoryNameList[indexPath.item]
            
            
            cell.categoriesLabel.text = item
            
            return cell
            
        case collectionView3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as! MoviesCollectionViewCell
            
            let data = categoryDataList[indexPath.row]
            
            if let url = data?.poster_path{
                cell.posterImage.kf.setImage(with: URL(string: (imageBaseURL + url)))
            }
            cell.backgroundColor = .clear
            return cell
            
        default:
            fatalError()
        }
        
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView{
        case collectionView1:
            let selectedId = topFiveList[indexPath.row]?.id
    
            let detailVC = DetailVC()
            detailVC.idRecieved = selectedId
            self.navigationController?.pushViewController(detailVC, animated: true)
    
            
        case collectionView2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
            let category = categoryNameList[indexPath.row]
            
            switch category{
            case "Now playing":
                self.vm.getRequest(type: CategoryType.nowPlaying.rawValue)
                collectionView2.reloadData()
            case "Upcoming":
                self.vm.getRequest(type: CategoryType.upcoming.rawValue)
                collectionView2.reloadData()
            case "Top rated":
                self.vm.getRequest(type: CategoryType.topRated.rawValue)
                collectionView2.reloadData()
            case "Popular":
                self.vm.getRequest(type: CategoryType.popular.rawValue)
                collectionView2.reloadData()
            case "Latests":
                self.vm.getRequest(type: CategoryType.latest.rawValue)
                collectionView2.reloadData()
            default:
                fatalError()
                
                
            }
        case collectionView3:
            let selectedId = categoryDataList[indexPath.row]?.id
            let detailVC = DetailVC()
            detailVC.idRecieved = selectedId
            navigationController?.pushViewController(detailVC, animated: true)
        default:
            print("--")
        }
        
    }
        
   
        
    
}
