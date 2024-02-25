//
//  ViewController.swift
//  sparrow-marathon-task9
//
//  Created by Nikita Bekish on 25.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Collection"
        return label
    }()

    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

