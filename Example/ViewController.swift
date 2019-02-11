//
//  ViewController.swift
//  Example
//
//  Created by Alex Nolasco on 2/10/19.
//

import UIKit
import CLTokenInputView

class ViewController: UIViewController {

    @IBOutlet weak var tokenInput: CLTokenInputView!
    @IBOutlet weak var tableView: UITableView!
    private var filteredScientist:[Scientist]!
    private var selectedScientists:[Scientist]!
    @IBOutlet var topLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Token Input Test";
    
        filteredScientist = []
        selectedScientists = []
        
        // token
        tokenInput.placeholderText = "Enter a name"
        tokenInput.fieldName = "To:"
        tokenInput.drawBottomBorder = true
        
        // table
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !tokenInput.isEditing {
            tokenInput.beginEditing()
        }
        super.viewDidAppear(animated)
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredScientist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let scientist = filteredScientist[indexPath.row]
        cell.textLabel?.text = scientist.name
        cell.detailTextLabel?.text = scientist.contribution
        
        if self.selectedScientists.contains(scientist) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let scientist = filteredScientist[indexPath.row]
        let token = CLToken(displayText: scientist.name, context: scientist)
        
        if self.tokenInput.isEditing {
            self.tokenInput.add(token)
        }
    }
}

// MARK: CLTokenInputViewDelegate
extension ViewController: CLTokenInputViewDelegate {
    func tokenInputView(_ view: CLTokenInputView, didChangeText text: String?) {
        guard let text = text, !text.isEmpty else {
            filteredScientist = []
            tableView.isHidden = true
            return
        }
        
        filteredScientist = ScientistsDataSource.chemists.filter({ (scientist) -> Bool in
            return scientist.name.lowercased().contains(text.lowercased())
        })
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func tokenInputView(_ view: CLTokenInputView, didAdd token: CLToken) {
        let scientist = token.context as! Scientist
        selectedScientists.append(scientist)
    }
    
    func tokenInputView(_ view: CLTokenInputView, didRemove token: CLToken) {
        let selectedScientist = token.context as! Scientist
        selectedScientists.removeAll { (scientist) -> Bool in
            return scientist.name == selectedScientist.name
        }
    }
    
    func tokenInputView(_ view: CLTokenInputView, tokenForText text: String) -> CLToken? {
        if !filteredScientist.isEmpty {
            let matchingName = filteredScientist.first!
            let matchToken = CLToken(displayText: matchingName.name, context: nil)
            return matchToken
        }
        // TODO: Perhaps if the text is a valid phone number, or email address, create a token
        // to "accept" it.
        return nil
    }
    
    func tokenInputViewDidEndEditing(_ view: CLTokenInputView) {
        view.accessoryView = nil
    }
    
    func tokenInputViewDidBeginEditing(_ view: CLTokenInputView) {
        self.view.removeConstraint(self.topLayoutConstraint)
        self.topLayoutConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraint(self.topLayoutConstraint)
        self.view.layoutIfNeeded()
    }
}
