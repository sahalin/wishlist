// 
//  AttractionsVC.swift
//  WishList
//
//  Created by Alexander on 17.05.2022.
//  
    
import UIKit

class AttractionsVC: WLViewController {
    let env: AppEnvironment
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Offering>!
    
    init(env: AppEnvironment) {
        self.env = env
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = Strings.attractionsTitle
        
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

extension AttractionsVC {
    enum Section: String {
        case main
    }
    
    func loadData() async throws -> NSDiffableDataSourceSnapshot<Section, Offering> {
        let offerings = try await env.networkManager.fetchOfferings()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Offering>()
        snapshot.appendSections([.main])
        snapshot.appendItems(offerings, toSection: .main)
        return snapshot
    }
}


// MARK: - Reload

extension AttractionsVC {
    func reload() {
        Task(priority: .userInitiated) {
            let snapshot = try! await loadData()
            await dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}


// MARK: - UICollectionView

extension AttractionsVC: UICollectionViewDelegate {
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, env) in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .none
            
            return NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
        }
        return layout
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Offering> {
        let venueCell = configureVenueCell()
        let exhibitionCell = configureExhibitionCell()
        
        let ds = UICollectionViewDiffableDataSource<Section, Offering>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.type {
            case .venue:
                return collectionView.dequeueConfiguredReusableCell(using: venueCell, for: indexPath, item: item)
            case .exhibition:
                return collectionView.dequeueConfiguredReusableCell(using: exhibitionCell, for: indexPath, item: item)
            }
        }
        
        return ds
    }
    
    func configureVenueCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Offering> {
        UICollectionView.CellRegistration<UICollectionViewListCell, Offering> { (cell, indexPath, offering) in
            var content: UIListContentConfiguration = .cell()
            content.text = offering.name
            
            cell.contentConfiguration = content
        }
    }
    
    func configureExhibitionCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, Offering> {
        UICollectionView.CellRegistration<UICollectionViewListCell, Offering> { (cell, indexPath, offering) in
            var content: UIListContentConfiguration = .cell()
            content.text = offering.name
            
            cell.contentConfiguration = content
        }
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        false
    }
}
