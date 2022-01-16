//
//  UserViewController.swift
//  IUD
//
//  Created by Manu Rico on 16/1/22.
//

import UIKit
import Alamofire

class UserViewController: UITableViewController {

  var users: [User] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    fetchData()
  }

  func fetchData() {
    APIManager.fetchUsers { data in
      if let users = data as? [User] {
        self.users = users
        self.tableView.reloadData()
      }
    } failure: { error in
      print("Error \(error.localizedDescription)")
    }
  }

  func configureTitle(
    for cell: UITableViewCell,
    with item: User
  ) {
    if let label = cell.viewWithTag(1000) as? UILabel {
      label.text = "#\(item.id ?? 0) - \(item.name ?? "(No name)")"
    }
  }

  func configureSubtitle(
    for cell: UITableViewCell,
    with item: User
  ) {
    if let label = cell.viewWithTag(1001) as? UILabel {
      label.text = "Date of birth: \(item.birthdate?.formatted() ?? "(No date)")"
    }
  }

  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowUser",
       let controller = segue.destination as? UserDetailViewController
    {
      controller.delegate = self
      if let user = sender as? User {
        controller.user = user
      }
    }
  }
}

extension UserViewController {
  // MARK: - Table View Data Source

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(
      withIdentifier: "UserListItem",
      for: indexPath)
    let item = users[indexPath.row]

    configureTitle(for: cell, with: item)
    configureSubtitle(for: cell, with: item)

    return cell
  }

  // MARK: Table View Delegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let user = users[indexPath.row]
    performSegue(withIdentifier: "ShowUser", sender: user)
  }

  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    users.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
}

// MARK: - UserDetailViewController Delegate

extension UserViewController: UserDetailViewControllerDelegate {

  func userDetailViewController(_ controller: UserDetailViewController, didFinishAdding item: User) {

    let newRowIndex = users.count
    users.append(item)

    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]

    navigationController?.popViewController(animated: true)

    tableView.insertRows(at: indexPaths, with: .automatic)
  }

  func userDetailViewController(_ controller: UserDetailViewController, didFinishEditing item: User) {

    if let index = users.firstIndex(where: { $0.id == item.id }) {
      users[index] = item
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureTitle(for: cell, with: item)
        configureSubtitle(for: cell, with: item)
      }
    }

    navigationController?.popViewController(animated: true)
  }
}
