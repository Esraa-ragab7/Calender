//
//  SlotCell.swift
//  Calender
//
//  Created by Esraa Mohamed Ragab on 9/13/19.
//  Copyright © 2019 Sally Freelance. All rights reserved.
//

import UIKit

class SlotCell: UICollectionViewCell {

    @IBOutlet weak var slotText: UILabel!
    @IBOutlet weak var slotView: UIView!
    
    func displayContent(text: String) {
        slotText.text = text
    }

}
