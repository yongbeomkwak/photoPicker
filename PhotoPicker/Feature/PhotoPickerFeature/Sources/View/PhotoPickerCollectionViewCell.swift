//
//  PhotoPickerCollectionViewCell.swift
//  PhotoPicker
//
//  Created by yongbeomkwak on 1/25/24.
//

import UIKit

class PhotoPickerCollectionViewCell: UICollectionViewCell {
    static let id : String = "PhotoPickerCollectionViewCell"
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
       
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        
        return imageView
        
    }()
    
    private let overlayLayer = CALayer()
    
    var cameraImageView: UIImageView = {
        
        let img = UIImage(systemName: "camera.fill")!.withRenderingMode(.alwaysTemplate)
        
        let imageView = UIImageView(image: img)
        
       
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
    
    
    var countLabel: UILabel = {
        
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .heavy, width: .standard)
        label.textColor = .white
        
        
        return label
    }()
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
     
     override init(frame: CGRect) {
       super.init(frame: frame)
         addSubviews()
         setLayout()
         setupOverlayLayer()
         cameraImageView.isHidden = true
     }
     
     override func prepareForReuse() {
       super.prepareForReuse()
      
     }
    
}

extension PhotoPickerCollectionViewCell {
    
    func addSubviews() {
        self.contentView.addSubviews(imageView,cameraImageView,countLabel)
    }
    
    func setLayout() {
        
        imageView.setLeft(anchor: self.contentView.leftAnchor, constant: .zero)
        imageView.setRight(anchor: self.contentView.rightAnchor, constant: .zero)
        imageView.setTop(anchor: self.contentView.topAnchor, constant: .zero)
        imageView.setBottom(anchor: self.contentView.bottomAnchor, constant: .zero)
           
        countLabel.setTop(anchor: self.contentView.topAnchor, constant: 10)
        countLabel.setRight(anchor: self.contentView.rightAnchor, constant: 10)
        countLabel.setHeight(20)
        countLabel.setWidth(20)
        countLabel.layer.cornerRadius = 10
        countLabel.layer.borderWidth = 2
        countLabel.clipsToBounds = true
        
        cameraImageView.setCenter(view: self.contentView, offset: .zero)
        cameraImageView.setWidth(30)
        cameraImageView.setHeight(30)
        
    }
    
    public func prepare(_ model:(num:Int, isSelected: Bool ,image: UIImage?)) {
        
    
        if model.image == nil { // 카메라 버튼
            cameraImageView.isHidden = false
            self.contentView.backgroundColor = colorFromRGB("CFD3D9")
            countLabel.isHidden = true
            return
        } else {
            imageView.image = model.image
        }
        
        
        if model.isSelected {
            selected(model)
        } else {
            deSelected(model)
        }
        
    }
    
    
    func selected(_ model: (num:Int, isSelected: Bool ,image: UIImage?)) {
        
        overlayLayer.isHidden = false
        imageView.layer.borderColor = UIColor.setColor(.primary).cgColor
        countLabel.layer.borderColor = UIColor.setColor(.primary).cgColor
        countLabel.backgroundColor = .setColor(.primary)
        countLabel.text = "\(model.num)"
        
        
    }
    
    func deSelected(_ mode: (num:Int, isSelected: Bool ,image: UIImage?)) {
        
        overlayLayer.isHidden = true
        imageView.layer.borderColor = UIColor.clear.cgColor
        countLabel.layer.borderColor = UIColor.white.cgColor
        countLabel.backgroundColor = .clear
      
    }
    
    private func setupOverlayLayer() { // 어두운 효과 오버레이
            overlayLayer.backgroundColor = UIColor.black.cgColor
            overlayLayer.opacity = 0.5 // 어두움의 정도를 조절할 수 있습니다.
            overlayLayer.frame = bounds
            imageView.layer.addSublayer(overlayLayer)
    }
}
