// 
//  OfferingsVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class OfferingsVC: WLViewController {
    enum Config {
        case venues
        case exhibitions
        case wishList
    }
    
    let env: AppEnvironment
    let config: Config
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Offering>!
    
    init(env: AppEnvironment, config: Config) {
        self.env = env
        self.config = config
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        switch config {
        case .venues:
            navigationItem.title = Strings.venuesTitle
        case .exhibitions:
            navigationItem.title = Strings.exhibitionsTitle
        case .wishList:
            navigationItem.title = Strings.wishListTitle
        }
        
        collectionView = .init(frame: .zero, collectionViewLayout: configureLayout())
        dataSource = configureDataSource()
        
        // Layout
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.frame = view.bounds
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        reload()
    }
}


// MARK: - Data

extension OfferingsVC {
    enum Section: String {
        case main
    }
    
    func loadData() async throws -> NSDiffableDataSourceSnapshot<Section, Offering> {
        var offerings = try await env.networkManager.fetchOfferings()
        
        switch config {
        case .venues:
            offerings = offerings
                .filter({ $0.type == .venue })
                .sorted(by: { $0.name < $1.name })
            
        case .exhibitions:
            offerings = offerings
                .filter({ $0.type == .exhibition })
                .sorted(by: { $0.startDate! < $1.startDate! })
            
        case .wishList:
            offerings = []
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Offering>()
        snapshot.appendSections([.main])
        snapshot.appendItems(offerings, toSection: .main)
        return snapshot
    }
}


// MARK: - Reload

extension OfferingsVC {
    func reload() {
        Task(priority: .userInitiated) {
            let snapshot = try! await loadData()
            await dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


// MARK: - UICollectionView

extension OfferingsVC: UICollectionViewDelegate {
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, env) in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .none
            
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
        }
        return layout
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Offering> {
        let offeringCell = configureOfferingCell()
        
        let ds = UICollectionViewDiffableDataSource<Section, Offering>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.type {
            case .venue, .exhibition:
                return collectionView.dequeueConfiguredReusableCell(using: offeringCell, for: indexPath, item: item)
            }
        }
        
        return ds
    }
    
    // MARK: Cells
    
    func configureOfferingCell() -> UICollectionView.CellRegistration<WLCustomViewListCell<OfferingView>, Offering> {
        UICollectionView.CellRegistration<WLCustomViewListCell<OfferingView>, Offering> { [unowned self] (cell, indexPath, offering) in
            cell.setCustomView({ OfferingView() })
            cell.customView.reload(offering: offering, networkManager: env.networkManager, didTapWishListButton: { button in
                button.isSelected.toggle()
            })
        }
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        false
    }
}
