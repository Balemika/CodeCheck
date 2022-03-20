//
//  ViewController.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 16/03/2022.
//

import UIKit

class ViewController: UICollectionViewController {

    fileprivate let cellId = "cellId"
    fileprivate let codeId = "codeId"
    let correctCodes = ["1111"]
    // Keypad titles for buttons
    let numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    // Current code
    var codeValue = ""
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.register(ATCodeField.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: codeId)
        collectionView.register(ATKeyCell.self, forCellWithReuseIdentifier: cellId)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Pressed on the button
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        codeValue += numbers[indexPath.item]
        // Creates tap vibration
        let lightImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        lightImpactFeedbackGenerator.impactOccurred()
        
        if codeValue.count >= 4 && correctCodes.contains(codeValue) {
            
            generateFeedback(type: .success)
            codeValue = ""
            
            let detailViewController:DetailViewController = DetailViewController()
            self.present(detailViewController, animated: true, completion: nil)
            
        } else if codeValue.count >= 4 {
            generateFeedback(type: .error)
            codeValue = ""
        }
        collectionView.reloadData()
    }
    
    
    // Creates the vibration feedback
    func generateFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    
    // Sets the title for code field
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let codeField = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: codeId, for: indexPath) as! ATCodeField
        var symbols = ""
        for _ in codeValue {
            symbols += "*"
        }
        codeField.numbersLabel.text = symbols
        return codeField
    }
    
    
    // Size of the code field
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = view.frame.height * 0.35
        return .init(width: view.frame.width, height: height )
    }
    
    
    // Count of buttons
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    
    // Sets the title for button
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ATKeyCell
        cell.digitsLabel.text = numbers[indexPath.item]
        return cell
    }
    
    
    // Space inside keypad
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = view.frame.width * 0.10
        let interSpacing = view.frame.width * 0.1
        let cellWidth = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing) / 3
        
        return .init(width: cellWidth, height: cellWidth)
    }
    
    
    // Space between button rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    // Keypad paddings
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightPadding = view.frame.width * 0.12
        return .init(top: 16, left: leftRightPadding, bottom: 16, right: leftRightPadding)
    }
}

