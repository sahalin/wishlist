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
        
        // Configure subviews
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addAction(UIAction() { [unowned self] action in
            let control = action.sender as? UIRefreshControl
            reload() {
                control?.endRefreshing()
            }
        }, for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        reload()
        
        NotificationCenter.default.addObserver(self, selector: #selector(storeDidSave), name: .StoreDidSave, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
}


// MARK: - Model

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
            let groupedOfferings = Dictionary(grouping: offerings, by: { $0.uniqueID })
            offerings = env.store.wishList.compactMap({ groupedOfferings[$0]?.first })
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Offering>()
        snapshot.appendSections([.main])
        snapshot.appendItems(offerings, toSection: .main)
        return snapshot
    }
}


// MARK: - Reload

extension OfferingsVC {
    func reload(completion: (() -> ())? = nil) {
        Task(priority: .userInitiated) {
            do {
                let reloadSnapshot = try await loadData()
                await dataSource.apply(reloadSnapshot, animatingDifferences: true)
                
                // Reconfigure visible cells on reload.
                // Data source diff is based on Offering, which does not include whether it was added to the wish list or not.
                // So when reloading after removing an item from the wish list, cells will not reconfigure and wish list button will remain selected.
                var reconfigureSnapshot = dataSource.snapshot()
                let visibleOfferings = collectionView.indexPathsForVisibleItems.compactMap({ dataSource.itemIdentifier(for: $0) })
                reconfigureSnapshot.reconfigureItems(visibleOfferings)
                await dataSource.apply(reconfigureSnapshot, animatingDifferences: true)
            } catch {
                // FIXME: Add user-facing error alert
                assertionFailure()
            }
            completion?()
        }
    }
}


// MARK: - UICollectionView

extension OfferingsVC: UICollectionViewDelegate {
    func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, env) in
            var config = UICollectionLayoutListConfiguration(appearance: .plain)
            config.headerMode = .none
            config.showsSeparators = false
            config.backgroundColor = Colors.groupedBackground
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: env)
            section.interGroupSpacing = .cardsSpacing()
            return section
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
            cell.setCustomView {
                OfferingView(networkManager: env.networkManager)
            }
            
            cell.customView.reload(offering: offering, inWishList: env.store.wishList.contains(offering.uniqueID), didTapWishListButton: { [unowned self] button in
                if !button.isSelected {
                    env.store.wishList.insert(offering.uniqueID, at: 0)
                } else {
                    if let idx = env.store.wishList.firstIndex(of: offering.uniqueID) {
                        env.store.wishList.remove(at: idx)
                    }
                }
                env.store.saveChanges()
                
                switch config {
                case .venues, .exhibitions:
                    button.isSelected.toggle()
                case .wishList:
                    // Prevent button state changes during disappear animation as offering will disappear on any button tap
                    break
                }
            })
            
            cell.backgroundConfiguration = .clear()
        }
    }
    
    // MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        false
    }
}


// MARK: - Notifications

@objc extension OfferingsVC {
    func storeDidSave() {
        reload()
    }
    
    func applicationWillEnterForeground() {
        reload()
    }
}
