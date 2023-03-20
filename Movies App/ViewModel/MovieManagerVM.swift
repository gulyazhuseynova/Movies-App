//
//  MovieManagerVM.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import UIKit


enum CategoryType : String{
    case nowPlaying = "now_playing?"
    case upcoming = "upcoming?"
    case topRated = "top_rated?"
    case popular = "popular?"
    case latest = "latest?"
    case none = ""
    
}

struct MovieManagerVM {
    
    var success: ((MainPageData?) -> Void)?
    var success2: ((MainPageData?) -> Void)?
    var success3: ((SearchPageData?) -> Void)?
    var success4: ((GetByIdData?) -> Void)?
    let apiKey = "09e54e853865d16fa3b6234c222ebc62"
    
    func getRequest (type: String) {
        let string = "https://api.themoviedb.org/3/movie/\(type)api_key=\(apiKey)&language=en-US&page=1"

        let url = URL(string: string)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: ", error?.localizedDescription ?? "")
                return
            } 
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(MainPageData.self, from: safeData)
                
                if type == CategoryType.topRated.rawValue{
                    self.success?(decodedData)
                    print("success top_rated")
                }else{
                    self.success2?(decodedData)
                    print("success category / or id")
                }
                
            }
        }
        session.resume()
    }
    
    func SearchTitleRequest (searchText: String) {
        
        let text = searchText.replacingOccurrences(of: " ", with: "+")
        
        let string = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&page=1&query=\(text.lowercased() ?? "")"
        print("ccc", string)
        let url = URL(string: string)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: ", error?.localizedDescription ?? "")
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(SearchPageData.self, from: safeData)
                
                self.success3?(decodedData)
                print("table success count:", decodedData?.results.count)
                print("success search")
            }
        }
        session.resume()
    }
    
    func getIdRequest (id: String) {
        let string = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=en-US&page=1"

        let url = URL(string: string)!
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: ", error?.localizedDescription ?? "")
                return
            }
            if let safeData = data {
                let decodedData = try? JSONDecoder().decode(GetByIdData.self, from: safeData)

                self.success4?(decodedData)
                print("success category / or id")
                
            }
        }
        session.resume()
    }
    
}



