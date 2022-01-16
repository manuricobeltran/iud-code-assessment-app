//
//  UserDetailViewController.swift
//  IUD
//
//  Created by Manu Rico on 16/1/22.
//

import UIKit

protocol UserDetailViewControllerDelegate: AnyObject {
  func userDetailViewController(
    _ controller: UserDetailViewController,
    didFinishAdding item: User)

  func userDetailViewController(
    _ controller: UserDetailViewController,
    didFinishEditing item: User)
}

class UserDetailViewController: UITableViewController, UITextFieldDelegate {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var doneBarButton: UIBarButtonItem!

  var user: User?
  weak var delegate: UserDetailViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let user = user {
      title = "#\(user.id ?? 0)"
      nameTextField.text = user.name
      doneBarButton.isEnabled = true
      datePicker.date = user.birthdate ?? Date()
    } else {
      nameTextField.becomeFirstResponder()
    }
  }

  // MARK: - Actions

  @IBAction func done() {
    print("DONE DONE")
    if let user = user {
      let updatedUser = User(
        id: user.id,
        name: nameTextField.text,
        birthdate: datePicker.date)
      delegate?.userDetailViewController(self, didFinishEditing: updatedUser)
    } else {
      let newUser = User(
        id: Int.random(in: 0...9999),
        name: nameTextField.text,
        birthdate: datePicker.date)
      delegate?.userDetailViewController(self, didFinishAdding: newUser)
    }
  }

  // MARK: - Table View Delegate

  override func tableView(
    _ tableView: UITableView,
    willSelectRowAt indexPath: IndexPath
  ) -> IndexPath? {
    return nil
  }

  // MARK: - Text Field Delegate

  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let oldText = textField.text!
    let stringRange = Range(range, in: oldText)!
    let newText = oldText.replacingCharacters(
      in: stringRange,
      with: string)

    doneBarButton.isEnabled = !newText.isEmpty

    return true
  }

}
