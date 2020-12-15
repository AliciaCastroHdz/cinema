//
//  MovieModel.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation
import ObjectMapper

public struct MovieModel: Mappable {
    var id: Int!
    var title: String!
    var isForAdults: Bool!
    var backdropPath: String?
    var posterPath: String?
    var genres: [GenreMovie]!
    var overview: String?
    var releaseDate: String!
    var runtime: Int?
    var score: Double!

    public init?(map: Map) { }

    public mutating func mapping(map: Map) {
        self.id                     <-          map["id"]
        self.title                  <-          map["title"]
        self.isForAdults            <-          map["adult"]
        self.backdropPath           <-          map["backdrop_path"]
        self.posterPath             <-          map["poster_path"]
        self.genres                 <-          map["genres"]
        self.overview               <-          map["overview"]
        self.releaseDate            <-          map["release_date"]
        self.runtime                <-          map["runtime"]
        self.score                  <-          map["vote_average"]
    }

    func getFullFormatReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.releaseDate)!
        dateFormatter.dateFormat = "d MMMM yyyy"
        let releaseDate = dateFormatter.string(from: date)
        return releaseDate
    }

    func getShortFormatReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.releaseDate)!
        dateFormatter.dateFormat = "d-MMM-yyyy"
        let releaseDate = dateFormatter.string(from: date)
        return releaseDate
    }
}

public struct GenreMovie: Mappable {
    var id: String!
    var name: String!

    public init?(map: Map) { }

    public mutating func mapping(map: Map) {
        self.id             <-          map["id"]
        self.name           <-          map["name"]
    }
}
