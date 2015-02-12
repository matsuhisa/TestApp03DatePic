//  ViewController.swift
//  TestApp03DatePic

import UIKit

class ViewController: UIViewController, UIToolbarDelegate {
    
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    //var textField: UITextField!
    var toolBar:UIToolbar!
    var myDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()


        fontLabel.text = "\u{f067}\u{f030}\u{f013}"
        fontLabel.font = UIFont(name:"FontAwesome",size:20)
        //fontLabel.setTitleTextAttributes([NSFontAttributeName:UIFont(name:"FontAwesome",size:20)!],forState:UIControlState.Normal)

        
        // 入力欄の設定
        //textField = UITextField(frame: CGRectMake(self.view.frame.size.width/3, 100, 0, 0))
        textField.placeholder = dateToString(NSDate())
        textField.text        = dateToString(NSDate())
        //textField.sizeToFit()
        self.view.addSubview(textField)
        
        // UIDatePickerの設定
        myDatePicker = UIDatePicker()
        myDatePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        myDatePicker.datePickerMode = UIDatePickerMode.Date
        textField.inputView = myDatePicker

        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        
        let toolBarBtn      = UIBarButtonItem(title: "\u{f030}", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        let selectedAttributes = [NSFontAttributeName : UIFont(name:"FontAwesome",size:14)]
        toolBarBtn.setTitleTextAttributes(selectedAttributes, forState: UIControlState.Normal)

        let toolBarBtnToday = UIBarButtonItem(title: "今日", style: .Bordered, target: self, action: "tappedToolBarBtnToday:")
        
        
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn, toolBarBtnToday]
        
        textField.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        textField.resignFirstResponder()
    }

    // 「今日」を押すと今日の日付をセットする
    func tappedToolBarBtnToday(sender: UIBarButtonItem) {
        myDatePicker.date = NSDate()
        changeLabelDate(NSDate())
    }
    
    //
    func changedDateEvent(sender:AnyObject?){
        var dateSelecter: UIDatePicker = sender as UIDatePicker
        self.changeLabelDate(myDatePicker.date)
    }
    
    func changeLabelDate(date:NSDate) {
        textField.text = self.dateToString(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let comps: NSDateComponents = calender.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit|NSCalendarUnit.SecondCalendarUnit|NSCalendarUnit.WeekdayCalendarUnit, fromDate: date)
        
        var date_formatter: NSDateFormatter = NSDateFormatter()
        var weekdays: Array  = [nil, "日", "月", "火", "水", "木", "金", "土"]
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy年MM月dd日（\(weekdays[comps.weekday])） "
        
        return date_formatter.stringFromDate(date)
    }
}

