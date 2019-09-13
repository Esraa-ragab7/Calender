//
//  SlotCell.swift
//  Calender
//
//  Created by Sally on 9/10/19.
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
