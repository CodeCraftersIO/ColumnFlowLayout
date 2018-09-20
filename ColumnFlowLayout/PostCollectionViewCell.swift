//
//  Created by Pierluigi Cifani on 20/09/2018.
//  Copyright © 2018 The Left Bit. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.layoutMargins = UIEdgeInsets(uniform: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel = UILabel.unlimitedLinesLabel()
    private let descriptionLabel = UILabel.unlimitedLinesLabel()
    private let authorAvatar = UIImageView()
    private let authorName = UILabel.unlimitedLinesLabel()
    
    struct VM {
        let photo: UIImage
        let title: String
        let description: String
        let authorName: String
        let authorAvatar: UIImage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.roundCorners(radius: 5)
        
        authorAvatar.contentMode = .scaleAspectFill
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        authorStackView.addArrangedSubview(authorAvatar)
        authorStackView.addArrangedSubview(authorName)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(descriptionLabel)
        textStackView.addArrangedSubview(authorStackView)
        
        contentView.addAutolayoutSubview(imageView)
        contentView.addAutolayoutSubview(textStackView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: textStackView.topAnchor),
            textStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.5),
            authorAvatar.widthAnchor.constraint(equalToConstant: 30),
            authorAvatar.heightAnchor.constraint(equalTo: authorAvatar.widthAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configureFor(viewModel: VM) {
        imageView.image = viewModel.photo
        titleLabel.attributedText = TextStyler.styler.attributedString(viewModel.title, forStyle: .subheadline).bolded
        descriptionLabel.attributedText = TextStyler.styler.attributedString(viewModel.description, color: .gray, forStyle: .footnote)
        authorName.attributedText = TextStyler.styler.attributedString(viewModel.authorName, color: .gray, forStyle: .footnote)
        authorAvatar.image = viewModel.authorAvatar
    }
}
