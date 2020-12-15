//
//  MovieMenuViewController.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import UIKit

class MovieMenuViewController: UIViewController, IMoviesPresenter {
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: MoviesPresenter?
    var movies: [MovieModel] = []

    private var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MoviesPresenter(view: self)
        self.presenter?.getNowPlayingList(page: 1)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let cell = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func showErrorAlert(title: String, msg: String?) { }
    
    func showResponse(response: [MovieModel]) {
        print("response: ", response.count)
        self.movies.append(contentsOf: response)
        self.collectionView.reloadData()
    }
}

extension MovieMenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return self.movies.count
    }


    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = self.movies[indexPath.row]
        cell.setMovie(movie)
      return cell
    }
    
    func collectionView(_: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let validation = self.movies.count - 1 == indexPath.row && self.movies.count % 20 == 0
        guard validation else { return }
        self.currentPage += 1
        self.presenter?.getNowPlayingList(page: self.currentPage)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        vc.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameWidth = self.collectionView!.frame.width
        let maxWidth = (frameWidth / 2) - 45
        return CGSize(width: maxWidth, height: maxWidth)
    }
}
