// 
//  OfferingView.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

class OfferingView: WLView {
    var offering: Offering! {
        didSet {
            reload()
        }
    }
    
    private let stackView = UIStackView()
    private let contentStackView = UIStackView()
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let wishListButton = UIButton()
    private lazy var locationLabel = IconLabel(theme: theme)
    private lazy var dateLabel = IconLabel(theme: theme)
    private lazy var priceLabel = IconLabel(theme: theme)
    private lazy var starsLabel = IconLabel(theme: theme)
    
    private let theme = Theme()
    
    convenience init(offering: Offering) {
        self.init()
        
        self.offering = offering
    }
    
    override func configure() {
        // Layout
        addSubview(stackView)
        addSubview(contentStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            // To prevent conflicts with cell's `UIView-Encapsulated-Layout-Height` and hide debugger complains
            heightAnchor.constraint(greaterThanOrEqualToConstant: theme.imageMinHeight).priority(.defaultHigh)
        ])
        
        contentStackView.axis = .vertical
        contentStackView.spacing = theme.contentSpacing
        contentStackView.directionalLayoutMargins = theme.contentMargins
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(locationLabel)
        contentStackView.addArrangedSubview(dateLabel)
        contentStackView.addArrangedSubview(starsLabel)
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(wishListButton)
        
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(contentStackView)
        
        imageView.widthAnchor.constraint(equalToConstant: theme.imageWidth).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        // Configure subviews
        imageView.backgroundColor = .systemFill
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        
        var buttonConfig: UIButton.Configuration = .gray()
        buttonConfig.cornerStyle = .capsule
        buttonConfig.buttonSize = .medium
        buttonConfig.imagePadding = theme.wishListButtonIconSpacing
        buttonConfig.image = theme.wishListButtonIcon
        buttonConfig.title = Strings.addToWishList
        wishListButton.configuration = buttonConfig
        wishListButton.tintColor = .systemPink
    }
    
    // MARK: Reload
    
    func reload() {
        guard let offering = offering else { assertionFailure(); return }
        
        // Title
        titleLabel.attributedText = offering.name.attributed(with: theme.titleAttributes)
        
        // Location
        if let location = offering.location {
            locationLabel.isHidden = false
            locationLabel.reload(icon: theme.locationIcon, attributedText: location.attributed(with: theme.detailTextAttributes))
        } else {
            locationLabel.isHidden = true
        }
        
        // Date
        if let date = offering.formattedDateInterval {
            dateLabel.isHidden = false
            dateLabel.reload(icon: theme.dateIcon, attributedText: date.attributed(with: theme.detailTextAttributes))
        } else {
            dateLabel.isHidden = true
        }
        
        // Stars
        if let stars = offering.formattedStarRating {
            starsLabel.isHidden = false
            starsLabel.reload(icon: theme.starsIcon, attributedText: stars.attributed(with: theme.detailTextAttributes))
        } else {
            starsLabel.isHidden = true
        }
        
        // Price
        priceLabel.reload(icon: theme.priceIcon, attributedText: offering.formattedPrice.attributed(with: theme.detailTextAttributes))
    }
}
