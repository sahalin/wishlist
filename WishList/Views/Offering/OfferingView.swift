// 
//  OfferingView.swift
//  WishList
//
//  Created by Alexander on 18.05.2022.
//  
    
import UIKit

class OfferingView: WLView {
    private let stackView = UIStackView()
    private let contentStackView = UIStackView()
    
    /// Is needed to avoid variable image sizes messing with the stack view.
    private let imageViewContainer = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let wishListButton = UIButton()
    private lazy var locationLabel = IconLabel(theme: theme)
    private lazy var dateLabel = IconLabel(theme: theme)
    private lazy var priceLabel = IconLabel(theme: theme)
    private lazy var starsLabel = IconLabel(theme: theme)
    
    private var wishListButtonActionHandler: ((UIButton) -> ())?
    
    private let theme = Theme()
    
    convenience init(offering: Offering, networkManager: NetworkManager) {
        self.init()
        
        reload(offering: offering, networkManager: networkManager)
    }
    
    override func configure() {
        // Layout
        addSubview(stackView)
        addSubview(contentStackView)
        imageViewContainer.addSubview(imageView)
        
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
        
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
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
        stackView.addArrangedSubview(imageViewContainer)
        stackView.addArrangedSubview(contentStackView)
        
        imageViewContainer.widthAnchor.constraint(equalToConstant: theme.imageWidth).isActive = true
        imageViewContainer.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        // Configure subviews
        imageViewContainer.backgroundColor = .systemFill
        imageViewContainer.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        
        wishListButton.configurationUpdateHandler = { [unowned self] button in
            var config: UIButton.Configuration = .gray()
            config.cornerStyle = .capsule
            config.buttonSize = .medium
            config.imagePadding = theme.wishListButtonIconSpacing
            config.image = theme.addToWishListButtonIcon
            config.title = Strings.addToWishList
            if button.isSelected {
                config.image = theme.addedTowishListButtonIcon
                config.title = Strings.addedToWishList
            }
            button.configuration = config
        }
        wishListButton.tintColor = .systemPink
        wishListButton.addAction(UIAction() { [unowned self] action in
            wishListButtonActionHandler?(action.sender as! UIButton)
        }, for: .touchUpInside)
    }
    
    // MARK: Reload
    
    func reload(offering: Offering, networkManager: NetworkManager, didTapWishListButton: ((UIButton) -> ())? = nil) {
        // Title
        titleLabel.attributedText = offering.name.attributed(with: theme.titleAttributes)
        
        // Location
        if let location = offering.location {
            locationLabel.isHidden = false
            locationLabel.reload(icon: theme.locationIcon, text: location)
        } else {
            locationLabel.isHidden = true
        }
        
        // Date
        if let date = offering.formattedDateInterval {
            dateLabel.isHidden = false
            dateLabel.reload(icon: theme.dateIcon, text: date)
        } else {
            dateLabel.isHidden = true
        }
        
        // Stars
        if let stars = offering.formattedStarRating {
            starsLabel.isHidden = false
            starsLabel.reload(icon: theme.starsIcon, text: stars)
        } else {
            starsLabel.isHidden = true
        }
        
        // Price
        priceLabel.reload(icon: theme.priceIcon, text: offering.formattedPrice)
        
        // Image
        Task { [weak self] in
            do {
                self?.imageView.image = try await networkManager.loadImage(at: offering.imageURL)
            } catch {
                assertionFailure()
            }
        }
        
        wishListButtonActionHandler = didTapWishListButton
    }
}
