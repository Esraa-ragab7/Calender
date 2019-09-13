//
//  ViewController.swift
//  Calender
//
//  Created by Sally on 9/12/19.
//  Copyright © 2019 Sally Freelance. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calender: Calender!
    @IBOutlet weak var slotsCollectionView: UICollectionView!
    
    var slots: [String] = ["09:00  AM", "12:00  PM", "12:00  PM", "12:00  PM"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        let endDate = dateFormatter.date(from: "2019 09 01")!
        let startDate = dateFormatter.date(from: "2019 09 30")!
        calender.displayContent(startDate: startDate, endDate: endDate, bookedOrNot: bookedOrNot, arrOFDates: arrOFDates, daysArray: daysArray)
        
    }


}

// MARK: - Collection View Delegate FlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
}

// MARK: - Collection View DataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlotCell", for: indexPath) as! SlotCell
        cell.displayContent(text: slots[indexPath.row])
        
        return cell
    }
    
    private func configureCollectionView() {
        slotsCollectionView.register(UINib(nibName: "SlotCell", bundle: nil), forCellWithReuseIdentifier: "SlotCell")
    }
}

