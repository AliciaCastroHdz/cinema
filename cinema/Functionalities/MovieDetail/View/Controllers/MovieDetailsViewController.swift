//
//  MovieDetailViewController.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 12/12/20.
//

import UIKit

class MovieDetailsViewController: BaseViewController, IMovieDetailsPresenter {
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loadingImageView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var stackView: UIStackView!

    var movie: MovieModel!
    var presenter: MovieDetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter = MovieDetailsPresenter(view: self)
        self.presenter?.getDetails(id: self.movie.id)
    }
    
    private func setupView() {
        let tintColor = UIColor(red: 63/255, green: 142/255, blue: 247/255, alpha: 1)
        self.backImage.image = UIImage(named: "ic_back")!.withRenderingMode(.alwaysTemplate)
        self.backImage.tintColor = tintColor
        
    }
    
    private func setDatas() {
        self.titleLabel.text = self.movie.title
        if let backdropPath = movie.backdropPath {
            let url = Strings.imagesBaseURL + backdropPath
            self.imageView.sd_setImage(with: URL(string: url)) { (image,_,_,_) in
                self.loadingImageView.isHidden = image != nil
            }
        }
        let titles = ["Duración: ",
                      "Fecha de estreno: ",
                      "Calificación:",
                      "Géneros: ",
                      "Descripción:"]
        let runtime = self.movie.runtime != nil ? self.movie.runtime! > 0 ? "\(self.movie.runtime!) min" : nil : nil
        let genres = self.movie.genres.map({ $0.name! }).joined(separator: ", ")

        let descriptions: [String?] = [runtime,
                                       self.movie.getFullFormatReleaseDate(),
                                       "\(self.movie.score!)",
                                       genres,
                                       self.movie.overview]

        titles.enumerated().forEach { (index, title) in
            if let description = descriptions[index], description.isValid() {
                self.stackView.addArrangedSubview(self.createPropertyView(title: title, description: description))
            }
        }
    }

    private func createPropertyView(title: String, description: String) -> PropertyView {
        let propertyView = PropertyView.init()
        propertyView.setProperty(title: title, description: description)
        return propertyView
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func showErrorAlert(title: String, msg: String?) { }

    func showResponse(response: MovieModel) {
        self.movie.genres = response.genres
        self.movie.runtime = response.runtime
        self.loadingView.isHidden = true
        self.setDatas()
    }
}
