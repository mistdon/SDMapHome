//
//  BookCell.swift
//  SDMapHome
//
//  Created by Allen on 16/4/17.
//  Copyright © 2016年 Allen. All rights reserved.
//

import UIKit
import SDWebImage

class BookCell: UITableViewCell {

    @IBOutlet weak var imgaeViewIcon: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var ratingView: UIView!
    
    @IBOutlet weak var detailLable: UILabel!
    
    func configureWithBook(book:Book){
        
        imgaeViewIcon.setResizeImageWith(book.image, width: imgaeViewIcon.frame.size.width)
        titleLable.text = book.title
        var detail = ""
        for str in book.author {
            detail += (str + "/")
        }
        detailLable.text = detail+book.publisher+"/"+book.pubdate
        
    }
    
}
