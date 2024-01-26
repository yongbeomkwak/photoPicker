//
//  EditListViewController.swift
//  PhotoPicker
//
//  Created by yongbeomkwak on 1/26/24.
//

import UIKit

class EditListViewController: UIViewController {

    var viewModel: EditListViewModel!
    
    var bottomContainerView: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    var cropButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "crop"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    var rotateButton: UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        button.tintColor = .white
        
        return button
        
    }()
    
    
    
    init(viewModel: EditListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayout()
        
    }
    
}

extension EditListViewController {
    
    func addSubviews() {
        self.view.addSubviews(bottomContainerView)
        bottomContainerView.addSubviews(cropButton,rotateButton)
        self.view.backgroundColor = .black
    }
    
    func setLayout() {
        
        bottomContainerView.setLeft(anchor: self.view.leftAnchor, constant: .zero)
        
        bottomContainerView.setRight(anchor: self.view.rightAnchor, constant: .zero)
        
        bottomContainerView.setBottom(anchor: self.view.bottomAnchor, constant: .zero)
        
        bottomContainerView.setHeight(70)
        
        cropButton.setWidth(50)
        cropButton.setHeight(50)
        cropButton.setTop(anchor: self.bottomContainerView.topAnchor, constant: .zero)
        cropButton.setBottom(anchor: self.bottomContainerView.bottomAnchor, constant: .zero)
        
        cropButton.setCenter(view: self.bottomContainerView, offset: .init(x: -50, y: 0))
        
        rotateButton.setWidth(50)
        rotateButton.setHeight(50)
        rotateButton.setTop(anchor: self.bottomContainerView.topAnchor, constant: .zero)
        rotateButton.setBottom(anchor: self.bottomContainerView.bottomAnchor, constant: .zero)
        
        rotateButton.setCenter(view: self.bottomContainerView, offset: .init(x: 50, y: 0))
            
        
        
    }
    
}


