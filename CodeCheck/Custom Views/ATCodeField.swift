//
//  ATCodeField.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 16/03/2022.
//

import UIKit

class ATCodeField: UICollectionReusableView {
    
    let numbersLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureNumbersLabel()
    }
    
    
    func configureNumbersLabel() {
        numbersLabel.text = "error"
        numbersLabel.font = numbersLabel.font.withSize(55)
        numbersLabel.adjustsFontSizeToFitWidth = true
        addSubview(numbersLabel)
        
        numbersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numbersLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numbersLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 60),
        ])
        
        // Spacing between digits
        let attributedString = NSMutableAttributedString(string: numbersLabel.text ?? "error")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(40.0), range: NSRange(location: 0, length: attributedString.length))
        numbersLabel.attributedText = attributedString
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
