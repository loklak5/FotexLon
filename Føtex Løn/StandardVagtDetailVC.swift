//
//  StandardVagtDetailVC.swift
//  Føtex Løn
//
//  Created by Martin Lok on 24/08/2016.
//  Copyright © 2016 Martin Lok. All rights reserved.
//

import UIKit

protocol StandardVagtDetailVCDelegate: class {
    func standardVagtDetailVCDidCancel(controller: StandardVagtDetailVC)
    func standardVagtDetailVC(controller: StandardVagtDetailVC, didFinishEditingVagt vagt: StandardVagt)
    func standardVagtDetailVC(controller: StandardVagtDetailVC, didFinishAddingVagt vagt: StandardVagt)
}

class StandardVagtDetailVC: UITableViewController {
    
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var endTimePicker: UIDatePicker!
    @IBOutlet weak var txtPause: UITextField!
    
    weak var delegate: StandardVagtDetailVCDelegate?
    
    let calendar = Calendar.current
    
    var standardVagtToEdit: StandardVagt?

    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributes(for: navigationController!.navigationBar)
        
        if let vagt = standardVagtToEdit {
            startTimePicker.date = vagt.startTime
            endTimePicker.date = vagt.endTime
            txtPause.text = String(vagt.pause) + " min"
        } else {
            var startComps = calendar.dateComponents(in: TimeZone.current, from: Date())
            startComps.minute = 0
            
            let endComps = calendar.dateComponents(in: TimeZone.current, from: Date(timeInterval: 60*60*4, since: calendar.date(from: startComps)!))
            
            startTimePicker.date = calendar.date(from: startComps)!
            endTimePicker.date = calendar.date(from: endComps)!
        }
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        var startDateComps = calendar.dateComponents(in: .current, from: startTimePicker.date)
        var newComps = startDateComps
        let endDateComps = calendar.dateComponents(in: .current, from: endTimePicker.date)
        startDateComps.hour = endDateComps.hour!
        startDateComps.minute = endDateComps.minute!
        
        if newComps.hour! > endDateComps.hour! || newComps.hour! == endDateComps.hour! && newComps.minute! >= endDateComps.minute!{
            let alert = UIAlertController(title: "Ups!", message: "Starttiden skal være før sluttiden", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            if let vagt = standardVagtToEdit {
                vagt.endTime = calendar.date(from: startDateComps)
                vagt.pause = Int(txtPause.text!.replacingOccurrences(of: " min", with: ""))
                delegate?.standardVagtDetailVC(controller: self, didFinishEditingVagt: vagt)
            } else {
                let standardVagt = StandardVagt(startTime: startTimePicker.date, endTime: calendar.date(from: startDateComps)!, pause: Int(txtPause.text!.replacingOccurrences(of: " min", with: ""))!)
                delegate?.standardVagtDetailVC(controller: self, didFinishAddingVagt: standardVagt)
            }
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.standardVagtDetailVCDidCancel(controller: self)
    }
    
}

// MARK: - UITextFieldDelegate

extension VagtDetailVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2 {
            let position = textField.position(from: textField.beginningOfDocument, offset: textField.text!.characters.count - 4)!
            textField.selectedTextRange = textField.textRange(from: position, to: position)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
