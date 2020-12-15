//
//  MovieCollectionViewCell.swift
//  cinema
//
//  Created by Alicia Monserrath Castro Hernandez on 09/12/20.
//

import Foundation
import SDWebImage
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!

    var movie: MovieModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = 20
        self.imageView.clipsToBounds = true
        let corners: UIRectCorner = [.bottomLeft, .bottomRight]
        self.overlayView.roundingCorners(corners)
        self.overlayView.clipsToBounds = true
        self.loadingView.alpha = 1
        self.setup(isEnable: false)
    }

    override func prepareForReuse() {
        self.imageView.image = nil
        self.movie = nil
        self.setup(isEnable: false)
    }

    func setMovie(_ movie: MovieModel) {
        self.movie = movie
        self.dateLabel.text = movie.getShortFormatReleaseDate()
        self.titleLabel.text = movie.title
        self.scoreLabel.text = "\(movie.score!)"
        if let posterPath = movie.posterPath {
            let url = Strings.imagesBaseURL + posterPath
            self.imageView.sd_setImage(with: URL(string: url)) { (image,_,_,_) in
                self.loadingView.isHidden = image != nil
                self.setup(isEnable: image != nil)
            }
        }
    }

    private func setup(isEnable: Bool) {
        self.overlayView.isHidden = !isEnable
    }
}
