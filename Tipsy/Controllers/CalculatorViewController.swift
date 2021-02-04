//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // Get Brain
    var billSplittingBrain = BillSplittingBrain()
    
    // Store these before using them in calculate pressed
    var tipPctText: String = "10%"
    var nPeople: Double = 2
    
    // IB Outlets
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    // IB Actions
    @IBAction func tipChanged(_ sender: UIButton) {
        // Init
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        billTextField.endEditing(true) // hide keyboard
        
        // Select button
        if sender.titleLabel!.text! == "0%" {
            zeroPctButton.isSelected = true
        } else if sender.titleLabel!.text! == "10%" {
            tenPctButton.isSelected = true
        } else if sender.titleLabel!.text! == "20%" {
            twentyPctButton.isSelected = true
        }
        
        // Store tip pct parameter
        tipPctText = sender.titleLabel!.text!
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        // Store # of people parameter
        nPeople = sender.value // Double
        
        // Show # of people in label
        splitNumberLabel.text = String(format: "%.0f", nPeople)
    }
    
    @IBAction func CalculatePressed(_ sender: UIButton) {
        let billTotalText = billTextField.text!
        billSplittingBrain.splitBill(billTotalText: billTotalText, tipPctText: tipPctText, nPeople: nPeople)
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.billPerPerson = billSplittingBrain.getBillPerPerson()
            destinationVC.setting = billSplittingBrain.getSetting()
        }
    }
    
    
}

