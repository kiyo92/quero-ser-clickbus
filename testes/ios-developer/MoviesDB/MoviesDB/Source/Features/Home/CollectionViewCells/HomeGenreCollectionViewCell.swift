//
//  HomeGenreCollectionViewCell.swift
//  MoviesDB
//
//  Created by Joao Marcus Dionisio Araujo on 19/01/22.
//

import UIKit

class HomeGenreCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "HomeGenreCollectionViewCell"
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var actionTitle: UILabel = {
        let label = UILabel()
        label.text = "Favoritos"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(hex: "#24143E")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    func setupData(genre: Genre){
        actionTitle.text = genre.name
    }
    
    func setup(){
        contentView.addSubview(container)
        container.addSubview(actionTitle)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        NSLayoutConstraint.activate([
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            actionTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            actionTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            actionTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            actionTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            
        ])
        
    }
    
}

