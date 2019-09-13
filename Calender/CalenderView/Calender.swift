//
//  Calender.swift
//  Calender
//
//  Created by Sally on 9/10/19.
//  Copyright © 2019 Sally Freelance. All rights reserved.
//

import Foundation

import UIKit
import JTAppleCalendar

@IBDesignable class Calender: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var calenderView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLAbel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    
    // MARK: - Properties
    var labelsArray: [UILabel]!
    var generateInDates: InDateCellGeneration = .forAllMonths
    var generateOutDates: OutDateCellGeneration = .tillEndOfGrid
    var clickable = true
    let dateFormatter = DateFormatter()
    var testCalendar = Calendar.current
    var startDate: Date = Date()
    var endDate: Date = Date()
    var totlalMargin: CGFloat = 60.0
    var i = 0
    var bookedOrNot: [Bool]!
    var daysArray: [Bool]!
    var arrOFDates: [states]!
    
    // MARK: - IBInspectables
    @IBInspectable var totlalMarginInt: CGFloat = 60.0 {
        didSet {
            self.totlalMargin = totlalMarginInt
        }
    }
    
    // MARK: - Display Data Function
    func displayContent(startDate: Date, endDate: Date, bookedOrNot: [Bool], arrOFDates: [states], daysArray: [Bool]){
        self.startDate = startDate
        self.endDate = endDate
        self.bookedOrNot = bookedOrNot
        self.arrOFDates = arrOFDates
        self.daysArray = daysArray
        for i in 0..<labelsArray.count {
            labelsArray[i].textColor = daysArray[i] ? UIColor.gray : UIColor.gold
        }
        calenderView.reloadData()
        calenderView.scrollToDate(startDate, triggerScrollToDateDelegate: true, animateScroll: false, preferredScrollPosition: nil, extraAddedOffset: 0) {}
    }
    
    // MARK: - Required Init
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    // MARK: - Next and Previous Functions
    @IBAction func next(_ sender: UIButton) {
        if clickable {
            let thisMonthDates = calenderView.visibleDates().monthDates
            let diffInDays = Calendar.current.dateComponents([.day], from: thisMonthDates[thisMonthDates.count - 1].date, to: endDate).day
            
            if diffInDays! > 0 {
                clickable = false
                calenderView.scrollToSegment(.next, triggerScrollToDateDelegate: true, animateScroll: true, extraAddedOffset: 0) {
                    self.clickable = true
                }
                
            }
        }
    }
    
    @IBAction func previous(_ sender: UIButton) {
        if clickable {
            
            let thisMonthDates = calenderView.visibleDates().monthDates
            let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: thisMonthDates[0].date).day
            
            if diffInDays! > 0 {
                clickable = false
                calenderView.scrollToSegment(.previous, triggerScrollToDateDelegate: true, animateScroll: true, extraAddedOffset: 0) {
                    self.clickable = true
                }
            }
            
        }
    }
    
}

// MARK: - TAppleCalendarViewDelegate
extension Calender: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let calenderCellView = calendar.dequeueReusableCell(withReuseIdentifier: "CalenderCellView", for: indexPath) as! CalenderCellView
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        
        if testCalendar.isDateInToday(date) && arrOFDates != nil {
            calenderCellView.displayContentData(dayText: "\(calanderDate.day!)", state: arrOFDates[i], booked: bookedOrNot[i], today: true)
            i = (i + 1) % 30
        } else if cellState.dateBelongsTo == .thisMonth && arrOFDates != nil {
            calenderCellView.displayContentData(dayText: "\(calanderDate.day!)", state: arrOFDates[i], booked: bookedOrNot[i])
            i = (i + 1) % 30
        } else {
            calenderCellView.displayContentData(dayText: "", state: .disabled, booked: false)
        }
        
        return calenderCellView
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let calenderCellView = cell as! CalenderCellView
        calenderCellView.displayContentData(dayText: "\(calanderDate.day!)", state: .selected, booked: false)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
        let calenderCellView = cell as! CalenderCellView
        calenderCellView.displayContentData(dayText: "\(calanderDate.day!)", state: .available, booked: false)
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    public func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        var calendar = Calendar.current
        calendar.timeZone = .current
        calenderView.scrollDirection = .horizontal
        let parameters = ConfigurationParameters(startDate: dateFormatter.date(from: "2019 01 01")!,
                                                 endDate: dateFormatter.date(from: "2020 01 01")!,
                                                 numberOfRows: 6,
                                                 calendar: calendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    
}

// MARK: - Init Functions
extension Calender {
    
    fileprivate func initUi() {
        dateFormatter.dateFormat = "yyyy MM dd"
        dateFormatter.timeZone = testCalendar.timeZone
        dateFormatter.locale = testCalendar.locale
        endDate = dateFormatter.date(from: "2020 01 01")!
        labelsArray = [sundayLabel, mondayLabel, tuesdayLAbel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel]
        calenderView.register(UINib(nibName: "PinkSectionHeaderView", bundle: Bundle.main),
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: "PinkSectionHeaderView")
        calenderView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        let nibName = UINib(nibName: "CalenderCellView", bundle:nil)
        calenderView.register(nibName, forCellWithReuseIdentifier: "CalenderCellView")
        calenderView.calendarDelegate = self
        calenderView.calendarDataSource = self
        
        calenderView.scrollDirection = .horizontal
        calenderView.allowsSelection = true
        calenderView.allowsMultipleSelection = false
        calenderView.minimumInteritemSpacing = 0
        calenderView.minimumLineSpacing = 0
        calenderView.scrollingMode = .stopAtEachCalendarFrame
        calenderView.isPagingEnabled = true
        calenderView.showsHorizontalScrollIndicator = false
        calenderView.showsVerticalScrollIndicator = false
        calenderView.cellSize = (UIScreen.main.bounds.width - totlalMargin) / 7
    }
    
    func commonInit() {
        
        guard let view = Bundle(for: type(of: self)).loadNibNamed("Calender", owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        frame = view.bounds
        
        self.addSubview(view)
        
        initUi()
    }
    
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = testCalendar.component(.year, from: startDate)
        monthLabel.text = monthName + " " + String(year)
    }
    
}
