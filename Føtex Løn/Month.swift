//
//  Month.swift
//  Føtex Løn
//
//  Created by Martin Lok on 03/08/2016.
//  Copyright © 2016 Martin Lok. All rights reserved.
//

import UIKit
import CoreData

class Month: NSObject {

    var fetchedRC: NSFetchedResultsController<NSFetchRequestResult>!
    var monthNumber: Double!
    
    var thisMonthIndex: Int!
    var months: [[Vagt]]!
    
    var vagt: Vagt!
    
    init(fetchedRC: NSFetchedResultsController<NSFetchRequestResult>, monthNumber: Double) {
        super.init()
        
        self.fetchedRC = fetchedRC
        self.monthNumber = monthNumber
        setThisMonthIndex()
        self.vagt = fetchedRC.sections![thisMonthIndex].objects!.first as! Vagt
    }
    
    private func setThisMonthIndex() {
        
        guard let sections = fetchedRC.sections else {
            return 
        }
        
        thisMonthIndex = 0
        
        for section in sections {
            let vagt = section.objects?[0] as! Vagt
            
            if monthNumber != vagt.monthNumber {
                thisMonthIndex! += 1
            } else {
                break
            }
        }
    }
    
    func calculateTotalLøn() -> Int {
     
        var løn = 0.0
        
        for vagt in fetchedRC.sections![thisMonthIndex].objects as! [Vagt] {
            if vagt.active {
                let vagtLøn = vagt.samletLon
                løn += vagtLøn
            }
        }
        
        return Int(løn)
    }
    
    func calculateAntalTimer() -> Double {
        var tid = 0.0
        
        for vagt in fetchedRC.sections![thisMonthIndex].objects as! [Vagt] {
            if vagt.active {
                let vagtTid = vagt.vagtITimer
                tid += vagtTid
            }
        }
        
        return tid
    }
    
    func calculateAntalMin() -> Int {
        var tid = 0
        
        for vagt in fetchedRC.sections![thisMonthIndex].objects as! [Vagt] {
            if vagt.active {
                let vagtTid = Int(vagt.vagtIMin)
                tid += vagtTid
            }
        }
        
        return tid
    }
    
    func calculateSatser() -> Int {
        var satser = 0.0
        
        for vagt in fetchedRC.sections![thisMonthIndex].objects as! [Vagt] {
            if vagt.active {
                let vagtSats = vagt.satser
                satser += vagtSats
            }
        }

        return Int(satser)
    }
    
    func calculateAntalVagter() -> Int {
        var count = 0
        
        for vagt in fetchedRC.sections![thisMonthIndex].objects as! [Vagt] {
            if vagt.active {
                count += 1
            }
        }
    
        return count
    }
    
    func getYear() -> Int {
        let comp = Calendar.current.component(.year, from: vagt.startTime)
        
        return comp
    }
    
    func getYearString() -> String {
        
        return vagt.getYearString()
    }
    
    func getMonthString() -> String {
        
        return vagt.getMonthString()
    }
}















