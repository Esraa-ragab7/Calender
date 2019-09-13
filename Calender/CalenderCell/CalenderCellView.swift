//
//  CalenderCellView.swift
//  ios-patient-app
//
//  Created by Sally on 12/25/18.
//  Copyright © 2019 Sally Freelance. All rights reserved.
//

import JTAppleCalendar

enum states {
    case disabled
    case unAvailable
    case available
    case fullyBooked
    case selected
}

class CalenderCellView: JTAppleCell {
    
    // MARK: - Outlets Of CalenderCellView
    @IBOutlet private var selectedView: UIView!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var bookedView: UIView!
    
    func displayContentData(dayText: String, state: states, booked: Bool, today: Bool = false) {
        dayLabel.text = dayText
        switch state {
        case .disabled:
            dayLabel.textColor = UIColor.gray50
            selectedView.backgroundColor = UIColor.clear
            selectedView.borderWidth = 0
            bookedView.isHidden = !booked
        case .unAvailable:
            dayLabel.textColor = UIColor.gold50
            selectedView.backgroundColor = UIColor.clear
            selectedView.borderWidth = 0
            bookedView.isHidden = !booked
        case .available:
            dayLabel.textColor = UIColor.gray
            selectedView.backgroundColor = UIColor.clear
            selectedView.borderWidth = 0
            bookedView.isHidden = !booked
        case .fullyBooked:
            dayLabel.textColor = UIColor.gray50
            selectedView.backgroundColor = UIColor.clear
            selectedView.borderWidth = 0
            bookedView.isHidden = !booked
        case .selected:
            dayLabel.textColor = UIColor.gray
            selectedView.backgroundColor = UIColor.gold20
            selectedView.borderWidth = 1
            bookedView.isHidden = !booked
            return
        }
        selectedView.backgroundColor = today ? UIColor.gold20 : UIColor.clear
    }
}
