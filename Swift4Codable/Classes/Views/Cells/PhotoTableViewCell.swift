//
//  PhotoTableViewCell.swift
//  RepliconTest
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import Foundation
import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoTitleLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setupCell(id: Int) {
        self.photoTitleLabel.text = AppManager.sharedInstance.getPhotoTitleForId(id: id)

        self.photoImageView.downloadImageFrom(link: AppManager.sharedInstance.getPhotoThumbnailForId(id: id), contentMode: UIViewContentMode.scaleAspectFit)
    }
}
