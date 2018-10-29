//
//  reviewCell.swift
//  eatingApp
//
//  Created by misael rivera on 12/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit

class reviewCell: UITableViewCell {
    
    @IBOutlet weak var nombreReview: UILabel!
    @IBOutlet weak var fechaReview: UILabel!
    @IBOutlet weak var reviewDice: UILabel!
    
    func actualizarVista(reviews: reviews) {
        nombreReview.text = reviews.nombreAutor
        fechaReview.text = reviews.fechaReview
        reviewDice.text = reviews.reviewDice
    }
}
