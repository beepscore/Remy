//
//  SettingsVC.swift
//  Remy
//
//  Created by Steve Baker on 6/17/21.
//  Copyright © 2021 Beepscore LLC. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    var settingsModel = SettingsModel()

    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var portTextField: UITextField!

    override func viewDidLoad() {
        hostTextField.delegate = self
        portTextField.delegate = self

        hostTextField.text = settingsModel.host
        portTextField.text = settingsModel.port
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsVC: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == hostTextField {
            settingsModel.host = textField.text ?? settingsModel.defaultHost
            return
        }

        if textField == portTextField {
            settingsModel.port = textField.text ?? settingsModel.defaultPort
        }
    }

    // https://stackoverflow.com/questions/274319/how-do-you-dismiss-the-keyboard-when-editing-a-uitextfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // user tapped return key
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // user tapped outside keyboard
        // cause keyboard to dismiss
        self.view.endEditing(true)
    }

}
