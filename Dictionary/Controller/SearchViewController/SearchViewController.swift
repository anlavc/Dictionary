//
//  SearchViewController.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit
class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var loginButtonBottomConstraint: NSLayoutConstraint!
    private var cell = "searchCell"
    var searchArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: cell)
        setupDelegate()
        searchTextView()
        keyboardNotification()
        searchTableView.backgroundColor = .white
        
    }
    
    //MARK: -   Notifications for when the keyboard opens/closes
    private func keyboardNotification() {
        self.searchTextField.delegate = self
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        // Move the view only when the usernameTextField or the passwordTextField are being edited
        if searchTextField.isEditing {
            moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.loginButtonBottomConstraint, keyboardWillShow: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, viewBottomConstraint: self.loginButtonBottomConstraint, keyboardWillShow: false)
    }
    func moveViewWithKeyboard(notification: NSNotification, viewBottomConstraint: NSLayoutConstraint, keyboardWillShow: Bool) {
        // Keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        // Keyboard's animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        // Change the constant
        if keyboardWillShow {
            let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0) // Check if safe area exists
            let bottomConstant: CGFloat = 20
            viewBottomConstraint.constant = keyboardHeight + (safeAreaExists ? 0 : bottomConstant)
        }else {
            viewBottomConstraint.constant = 20
        }
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            // Update Constraints
            self?.view.layoutIfNeeded()
        }
        // Perform the animation
        animator.startAnimation()
    }
    private func setupDelegate() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    private func searchTextView() {
        searchView.layer.shadowColor = UIColor.gray.cgColor
        searchView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        searchView.layer.masksToBounds = false
        searchView.layer.shadowRadius = 1.0
        searchView.layer.shadowOpacity = 0.5
        searchView.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.object(forKey: "searchText") as? [String] {
            searchArray = data.uniqued()
            searchTableView.reloadData()
        } else {
            print("Arama fonksiyonunda veri çekilirken bir sorunla karşılaştı")
        }
    }
    //Text Correct
    func checkWord(word: String) -> Bool {
        let wordChecker = UITextChecker()
        let textRange = NSRange(location: 0, length: word.count)
        let textMisspelledRange = wordChecker.rangeOfMisspelledWord(in: word, range: textRange, startingAt: 0, wrap: false, language: "en")
        return textMisspelledRange.location == NSNotFound
    }
    
    //MARK: - SearchButton
    @IBAction func searchButtonPressed(_ sender: Any) {
        if !searchTextField.text.isNilOrEmpty && checkWord(word:searchTextField.text!) == true  {
            searchArray.append(searchTextField.text!)
            UserDefaults.standard.set(searchArray, forKey: "searchText")
            performSegue(withIdentifier: "searchtoDetail", sender: nil)
        } else {
           
            if checkWord(word:searchTextField.text!) == false {
                searchTextField.addDottedBottomLine()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.showAlertView(title: "Error Word!", message: "You entered an incorrect word.", alertActions: [])
                }
            } else if searchTextField.text.isNilOrEmpty {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.showAlertView(title: "Error!", message: "You should write a word...", alertActions: [])
                    
                }
            }
         
            keyboardWillHide(NSNotification(name: UIResponder.keyboardWillHideNotification, object: nil))
        }
    }
    //MARK: - Segue to SearchDetail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchtoDetail" {
            let gidilecekVC = segue.destination as! SearchDetailViewController
            gidilecekVC.searchText = searchTextField.text!
        }
    }
}
// MARK: - Table view data source
extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count == nil ? 0 : searchArray.prefix(5).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchTableView.dequeueReusableCell(withIdentifier: cell, for:  indexPath) as! SearchTableViewCell
        cell.searchLabel.text = searchArray.reversed()[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "searchVC") as? SearchDetailViewController
        vc?.searchText = searchArray.reversed()[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension SearchViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Close keyboard when you press 'return'
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if searchTextField.text == "" {
            for layer in searchTextField.layer.sublayers ?? [] {
                if let shapelayer = layer as? CAShapeLayer {
                    shapelayer.removeFromSuperlayer()
                }
            }
        }
    }
}
