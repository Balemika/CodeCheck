//
//  ATKeyCell.swift
//  CodeCheck
//
//  Created by Ņikita Roldugins on 16/03/2022.
//

import UIKit

class ATKeyCell: UICollectionViewCell {
    
    let digitsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureDigitsLabel()
        configureStackView()
    }
    
    
    func configureDigitsLabel() {
        digitsLabel.text = "-"
        digitsLabel.font = UIFont.systemFont(ofSize: 32)
        digitsLabel.textAlignment = .center
    }
    
    
    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [digitsLabel])
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
