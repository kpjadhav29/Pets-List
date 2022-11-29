//
//  PetsTableViewCell.swift
//  SepiaTask
//
//  Created by Kiran Jadhav on 29/11/22.
//

import UIKit

class PetsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgViewPet: ImageLoader!
    @IBOutlet weak var lblPetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension PetsTableViewCell {
    
    func setupData(petData:Pets) {
        self.lblPetName?.text = petData.title
        self.imgViewPet?.loadImageWithUrl(URL(string: petData.image_url!)!)
    }
}
