//
//  MovieData.swift
//  Movies App
//
//  Created by Gulyaz Huseynova on 16.03.23.
//

import Foundation


let categoryNameList = ["Now playing", "Upcoming", "Top rated", "Popular", "Latests"]
let imageBaseURL = "https://image.tmdb.org/t/p/original/"

struct MainPageData : Codable {
    let results: [Results?]

}

struct Results : Codable {
    let id: Int?
    let original_title : String?
    let poster_path : String?
}

struct SearchPageData : Codable {
    let results: [Results2?]

}

struct Results2 : Codable {
    let id: Int?
    let original_title : String?
    let poster_path : String?
    let vote_average: Double?
    let release_date: String?
    let total_results: Int?
    let genre_ids: [Int?]
}

struct GetByIdData : Codable {
    let original_title: String?
    let poster_path : String?
    let runtime: Int?
    let overview: String?

}




let genreIdDict = [28:"Action", 12:"Adventure", 16:"Animation", 35:"Comedy", 80:"Crime", 99:"Documentary",18:"Drama", 10751:"Family", 14:"Fantasy", 36:"History", 27:"Horror", 10402:"Music",9648:"Mystery",10749:"Romance", 878:"Sci-Fiction", 10770:"TV Movie", 53: "Thriller", 10752: "War", 37:"Western"]


//
//struct Results : Codable {
//    let id: Int?
//    let name : String?
//    let status : String?
//    let species : String?
//    let type : String?
//    let gender : String?
//    let origin : Origin?
//    let location : Location?
//    let image : URL?
//    let episode : [String?]
//    
//}
