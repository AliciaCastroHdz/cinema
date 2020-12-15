//
//  MoviesServices.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import SwiftyJSON


public enum MoviesServices: IEndpoint {
    case getDetails(id: Int)
    case getImages
    case getNowPlayingList(page: Int)

    public var description: String {
        return "MoviesServices"
    }

    public var isAuth: Bool {
        switch self {
        case .getDetails, .getImages, .getNowPlayingList:
            return true
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getDetails, .getImages, .getNowPlayingList:
            return .get
        }
    }

    var parameter: Parameters? {
        var params: Parameters = ["api_key": Strings.apiKey,
                                  "language": "es-MX"]
        switch self {
        case .getDetails, .getImages:
            break
        case .getNowPlayingList(let page):
            params["page"] = "\(page)"
        }

        return params
    }

    var header: HTTPHeaders? {
        return nil
    }

    var encoding: ParameterEncoding  {
        switch self {
        case .getDetails, .getImages, .getNowPlayingList:
            return URLEncoding.default
        }
    }

    var path: String {
        let path: String
        switch self {
        case .getDetails(let id):
            path = "\(id)"
        case .getImages:
            path = ""
        case .getNowPlayingList:
            path = "now_playing"
        }
        print("path: ", Strings.baseURL + Strings.moviePath + path)
        return Strings.baseURL + Strings.moviePath + path
    }
}
