//
//  ViewController.swift
//  StarCalc
//
//  Created by Marc D. Nichitiu on 3/9/23.
//

import Cocoa

class LumMagViewController: NSViewController {

    @IBOutlet weak var knownQuantity: NSTextField!
    
    @IBOutlet weak var whatToSolveFor: NSPopUpButton!
    
    
    @IBOutlet weak var distField: NSTextField!
    @IBOutlet weak var ResultField: NSTextField!
    
    @IBOutlet weak var distUnits: NSPopUpButton!
    
    @IBOutlet weak var isMainSequence: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func calculate(_ sender: Any) {
        let input = Double(knownQuantity.stringValue)
        var dist = Double(distField.stringValue)
        let distUnit = distUnits.indexOfSelectedItem // 0 = pc, 1 = ly, 2 = mas
        
        if(distUnit == 1) {
            dist = dist!/3.261563
        }
        else if(distUnit == 2) {
            // d = 1/p
            dist = 1/(dist!/1000)
        }
        
        
        let whatGiven = whatToSolveFor.indexOfSelectedItem
        if(whatGiven == 2) { // FIND LUMINOSITY
            let L0 = 3.0128e28 // W
            let Lsun = 3.9e26 // W
            let exp = -0.4*(input!+5-5*log10(dist!))
            let lum = L0 * pow(10, exp)
            let lumFactor = lum / Lsun
            
            var strExtra = ""
            if(isMainSequence.state == NSControl.StateValue.on) {
                let mass = pow(lumFactor,1/3.5)
                let Msun = 1.989E30 //kg
                let massKg = mass*Msun
                strExtra = ". Mass \(mass) Msun =  \(massKg) kg"
            }
            
            ResultField.stringValue = "Luminosity of star is \(lum) W or \(lumFactor) L_sun. Distance is \(dist!) pc, \(dist!*3.261563) ly, and has a parallax of \(1/dist! * 1000) mas. Abs Magnitude: \(input!+5-5*log10(dist!)), App Magnitude: \(input!)\(strExtra)"
            
            
            
            
        }
        else if (whatGiven == 0) { // FIND Magnitude
            print("Calculating Magnitudes given \(input!) L_sun at a distance \(dist) pc")
            let Lsun = 3.9e26 // W
            let input2 = input!*Lsun
            let Mbol = -2.5*log10(input2) + 71.1974 // magnitude
            let M_app = Mbol - 5 + 5*log10(dist!)
            
            var strExtra = ""
            if(isMainSequence.state == NSControl.StateValue.on) {
                let mass = pow(input!,1/3.5)
                let Msun = 1.989E30 //kg
                let massKg = mass*Msun
                strExtra = ". Mass \(mass) Msun =  \(massKg) kg"
            }
            
            ResultField.stringValue = "Absolute magnitude of star is \(Mbol); apparent magnitude is \(M_app). Distance is \(dist!) pc, \(dist!*3.261563) ly, and has a parallax of \(1/dist! * 1000) mas.\(strExtra)"
        }
        else if (whatGiven == 1){ // FIND Magnitude
            let Lsun = 3.9e26 // W
            //let input2 = input!*Lsun
            let Mbol = -2.5*log10(input!) + 71.1974 // magnitude
            let M_app = Mbol - 5 + 5*log10(dist!)
            
            var strExtra = ""
            if(isMainSequence.state == NSControl.StateValue.on) {
                let mass = pow(input!/Lsun,1/3.5)
                let Msun = 1.989E30 //kg
                let massKg = mass*Msun
                strExtra = ". Mass \(mass) Msun =  \(massKg) kg"
            }
            
            
            
            ResultField.stringValue = "Absolute magnitude of star is \(Mbol); apparent magnitude is \(M_app). Distance is \(dist!) pc, \(dist!*3.261563) ly, and has a parallax of \(1/dist! * 1000) mas. Abs Magnitude: \(Mbol), App Magnitude: \(M_app)\(strExtra)"
        }
        else { // FIND LUMINOSITY FROM ABS MAG
            let L0 = 3.0128e28 // W
            let Lsun = 3.9e26 // W
            
            let exp = -0.4*(input!)
            let lum = L0 * pow(10, exp)
            let lumFactor = lum / Lsun
            
            var strExtra = ""
            if(isMainSequence.state == NSControl.StateValue.on) {
                let mass = pow(lumFactor,1/3.5)
                let Msun = 1.989E30 //kg
                let massKg = mass*Msun
                strExtra = ". Mass \(mass) Msun =  \(massKg) kg"
            }
            
            
            ResultField.stringValue = "Luminosity of star is \(lum) W or \(lumFactor) L_sun. Distance is \(dist!) pc, \(dist!*3.261563) ly, and has a parallax of \(1/dist! * 1000) mas. Abs Magnitude: \(input!), App Magnitude: \(input!  - 5 + 5*log10(dist!))\(strExtra)"
        }
        
    }
    
    

}





class BinSysViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBOutlet var periodField: NSTextField!
    @IBOutlet var separationField: NSTextField!
    @IBOutlet var resultField: NSTextField!
    @IBOutlet var periodUnits: NSPopUpButton!
    @IBOutlet var separationUnits: NSPopUpButton!
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func calculate(_ sender: Any?) {
        var orbitalPeriodYears = 0.0
        switch periodUnits.indexOfSelectedItem {
        case 0:
            orbitalPeriodYears = Double(periodField.stringValue)!
        case 1:
            orbitalPeriodYears = Double(periodField.stringValue)!/365
        case 2:
            orbitalPeriodYears = Double(periodField.stringValue)!/365/24/60/60
        default:
            orbitalPeriodYears = Double(periodField.stringValue)!
        }
        
        var separationAU = 0.0
        switch separationUnits.indexOfSelectedItem {
        case 0:
            separationAU = Double(separationField.stringValue)!
        case 1:
            separationAU = Double(separationField.stringValue)!*63241.077088066
        case 2:
            separationAU = 1/(Double(separationField.stringValue)!/1000)*63241.077088066*3.261563
        default:
            separationAU = Double(separationField.stringValue)!
        }
        
        var mTot = separationAU*separationAU*separationAU/orbitalPeriodYears/orbitalPeriodYears
        
        resultField.stringValue = "Total mass is \(mTot) solar masses = \(mTot*1.9891e30) kg"
        
        
    }
    
    
    
    
    
    
    
}



class RRLyraeViewController: NSViewController {
    
    
}
