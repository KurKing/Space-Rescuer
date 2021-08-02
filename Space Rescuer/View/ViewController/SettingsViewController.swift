//
//  SettingsViewController.swift
//  Space Rescuer
//
//  Created by Oleksiy on 02.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addCollectionView()
        addHeader()
        
        setUpKeyBoard()
    }
    
    

}

//MARK: - UICollectionViewDataSource
extension SettingsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 2 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = [UIColor.red, UIColor.yellow,UIColor.green][(indexPath.row+indexPath.section)%3]
        return cell
    }
}

//MARK: - Keyboard
private extension SettingsViewController {
    func setUpKeyBoard() {
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        
        collectionView?.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10-keyboardFrame.height)
        }
        view.layoutIfNeeded()
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        collectionView?.snp.updateConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        view.layoutIfNeeded()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 2 {
            return CGSize(width: view.bounds.width-20, height: 60)
        }
        
        let sizeConstant = (view.bounds.width-20)/2
        return CGSize(width: sizeConstant, height: sizeConstant)
    }
}

//MARK: - UICollectionViewDelegate
extension SettingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !(indexPath.section == 2)
    }
}

//MARK: - SettingsViewController
private extension SettingsViewController {
    
    func addHeader() {
        //dismiss button
        let button = UIButton(type: .system)
        
        button.backgroundColor = .clear
        button.tintColor = .clear
        button.setBackgroundImage(UIImage(named: .xButton), for: .normal)
        button.addTarget(self, action: #selector(xButtonPressed), for: .touchUpInside)
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-7)
        }
        
        //title
        let label = UILabel()
        
        label.textColor = .black
        label.backgroundColor = .clear
        label.font = UIFont(name: .customFontName, size: 30)
        label.text = .title
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(button.snp.centerY)
        }
    }
    
    @objc private func xButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(CheatCodeCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)

            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        self.collectionView = collectionView
    }
    
}
