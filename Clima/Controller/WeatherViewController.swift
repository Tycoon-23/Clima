//
//  ViewController.swift
//  Clima
//
//  Created by Aditya Virbhadra Vyavahare on 05/11/22.
//

import UIKit

class WeatherViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self //initialize the search bar
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)    //fetch text data from search bar
    }
    
    //asks the delegate whether to process the return command given by user via the keyboard
    func textFieldShouldReturn(_ textField: UITextField)  -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            searchTextField.placeholder = "Search"  //reset placeholder to 'Search'
            return true
        } else {
            searchTextField.placeholder = "Type city name here" //modify placeholder if user did not enter any name
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //use user I/P to fetch weather data.
    }
}

