//
//  AllCalenderWithSlots.swift
//  Calender
//
//  Created by Sally on 9/10/19.
//  Copyright © 2019 Sally Freelance. All rights reserved.
//

import UIKit

class AllCalenderWithSlots: UIView {
    @IBOutlet weak var calender: Calender!
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    var slots: [String] = ["09:00  AM", "12:00  PM", "12:00  PM", "12:00  PM", "09:00  AM", "12:00  PM", "12:00  PM", "12:00  PM"]
    
    let arrOFDates: [states] = [
        .unAvailable, .fullyBooked, .unAvailable, .fullyBooked, .unAvailable, .available, .available,
        .unAvailable, .available, .unAvailable, .available, .unAvailable, .available, .available,
        .unAvailable, .available, .unAvailable, .available, .unAvailable, .available, .available,
        .unAvailable, .fullyBooked, .unAvailable, .available, .unAvailable, .available, .available,
        .unAvailable, .available
    ]
    
    let bookedOrNot: [Bool] = [
        false, false, false, false, false, false, false,
        false, true, false, false, false, false, false,
        false, false, false, false, false, true, false,
        false, false, false, false, false, false, true,
        false, false
    ]
    
    let daysArray: [Bool] = [
        false, true, false, true, false, true, true
    ]
    
    // MARK: - init
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
}

// MARK: - Collection View Delegate FlowLayout
extension AllCalenderWithSlots: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 30 )/4, height: 30)
    }
}

// MARK: - Collection View DataSource
extension AllCalenderWithSlots: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCell
        cell.displayContent(text: slots[indexPath.row])
        
        return cell
    }
    
    private func configureCollectionView() {
        let numberOfRows = ((slots.count / 4) +  (slots.count % 4 != 0 ? 1 : 0))
        collectionHeight.constant = CGFloat(numberOfRows * 30 + (numberOfRows - 1) * 10)
        slotsCollectionView.register(UINib(nibName: "SlotCell", bundle: nil), forCellWithReuseIdentifier: "SlotCell")
    }
}

extension AllCalenderWithSlots {
    private func commonInit() {
        guard let view = Bundle(for: type(of: self)).loadNibNamed("AllCalenderWithSlots", owner: self, options: nil)?.first as? UIView else {
            return
        }
        frame = view.bounds
        
        self.addSubview(view)
        
        configureCollectionView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        let endDate = dateFormatter.date(from: "2019 09 01")!
        let startDate = dateFormatter.date(from: "2019 09 30")!
        calender.displayContent(startDate: startDate, endDate: endDate, bookedOrNot: bookedOrNot, arrOFDates: arrOFDates, daysArray: daysArray)
    }
}
