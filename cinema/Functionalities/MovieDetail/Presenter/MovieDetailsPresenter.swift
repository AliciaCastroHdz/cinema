//
//  MovieDetailsPresenter.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import Foundation
import RxSwift
import SwiftyJSON
import ObjectMapper

protocol IMovieDetailsPresenter: class {
    func showErrorAlert(title: String, msg: String?)
    func showResponse(response: MovieModel)
}

class MovieDetailsPresenter {
    weak var view: IMovieDetailsPresenter?

    init(view: IMovieDetailsPresenter?) {
        self.view = view
    }

    func getDetails(id: Int) {
        let _ = self.getDetailsResponse(id: id)
            .subscribe(
                onNext: { [weak self] response in
                    guard let weakSelf = self else { return }
                    weakSelf.view?.showResponse(response: response)
                }
            )
    }

    private func getDetailsResponse(id: Int) -> Observable<MovieModel> {
        let observer: Observable<JSON> = NetworkService.share.getResponse(endpoint: MoviesServices.getDetails(id: id))
        return observer
            .flatMap { json -> Observable<MovieModel> in
                guard let json = json.dictionaryObject,
                   let movie = Mapper<MovieModel>().map(JSON: json) else {
                    return Observable.error(HttpNetworkingError.jsonSerializationFailed(HttpRequestError.mappingError.error))
                }

                return Observable.just(movie)
            }
            .catchError { _ in
                return Observable.error(HttpNetworkingError.notResponse)
            }
    }
}
