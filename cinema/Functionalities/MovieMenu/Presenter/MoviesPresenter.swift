//
//  MoviesPresenter.swift
//  FREESTYLE
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

protocol IMoviesPresenter: class {
    func showErrorAlert(title: String, msg: String?)
    func showResponse(response: [MovieModel])
}

class MoviesPresenter {
    weak var view: IMoviesPresenter?

    init(view: IMoviesPresenter?) {
        self.view = view
    }
    
    func getNowPlayingList(page: Int) {
        let _ = self.getNowPlayingListResponse(page: page)
            .subscribe(
                onNext: { [weak self] response in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.showResponse(response: response)
                }
            )
    }
    
    private func getNowPlayingListResponse(page: Int) -> Observable<[MovieModel]> {
        let observer: Observable<JSON> = NetworkService.share
            .getResponse(endpoint: MoviesServices.getNowPlayingList(page: page))
        return observer
            .flatMap { json -> Observable<[MovieModel]> in
                guard let results = json["results"].array else {
                    return Observable.error(HttpNetworkingError.jsonSerializationFailed(HttpRequestError.mappingError.error))
                }
                
                var movies: [MovieModel] = []
                for item in results  {
                    if let json = item.dictionaryObject,
                       let value = Mapper<MovieModel>().map(JSON: json) {
                        movies.append(value)
                    }
                }
                return Observable.just(movies)
            }
            .catchError { _ in
                return Observable.just([])
            }
    }
}
