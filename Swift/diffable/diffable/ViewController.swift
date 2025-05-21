//
//  ViewController.swift
//  diffable
//
//  Created by air on 5/21/25.
//

import UIKit

class ViewController: UIViewController {
    enum ViewType {
        case full
        case half
        case halfEnd
    }
    enum Section: Hashable {
        case first
        case second
    }
    
    enum Item: Hashable {
        case firstItem(String)
        case twoItem(Int)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 3. dataSource 인스턴스 정의
    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
    var viewType = ViewType.full
    var tempFirstItem = Item.firstItem("")
    var tempSecondItems = (0..<30).map { Item.twoItem($0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    @IBAction func firstButtonClicked(_ sender: UIButton) {
//        //확정
        collectionView.setContentOffset(.zero, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            guard let self else { return }
            var snapshot = dataSource.snapshot()
            snapshot.insertSections([.first], beforeSection: .second)
            snapshot.appendItems([tempFirstItem], toSection: .first)
            collectionView.setCollectionViewLayout(createBasicListLayout(viewType: .full), animated: true)
            dataSource.apply(snapshot, animatingDifferences: true)
            collectionView.contentOffset.y = 0
        }
    }
    
    @IBAction func secondButtonClicked(_ sender: UIButton) {
        // 확정
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([tempFirstItem])
        dataSource.apply(snapshot, animatingDifferences: true)
//        collectionView.setCollectionViewLayout(createBasicListLayout(viewType: .half), animated: true) 
        collectionView.setCollectionViewLayout(createBasicListLayout(viewType: .half), animated: true) { [weak self] _ in
            snapshot.deleteSections([.first])
            self?.dataSource.apply(snapshot, animatingDifferences: false)
            self?.collectionView.setCollectionViewLayout(self!.createBasicListLayout(viewType: .halfEnd), animated: false)
            self?.collectionView.contentOffset.y = 0
        }
    }
    
    func configureCollectionView() {
        // 1. layout 등록. "셀들을 어떻게"
        collectionView.collectionViewLayout = createBasicFullListLayout()
        // 2. 셀 등록 "어떤 셀들을 사용할건가?"
        configureCells()
        // 4. dataSource 할당 "Data와 Cell을 매치시키기"
        configureDataSource()
        // 5. snapshot 적용, "어떤 데이터를 사용할 것인가"
        configureSnapshot()
    }
    
    func configureCells() {
        let firstNib = UINib(nibName: "FirstCollectionViewCell", bundle: nil)
        collectionView.register(firstNib, forCellWithReuseIdentifier: "FirstCollectionViewCell")
        let secondNib = UINib(nibName: "SecondCollectionViewCell", bundle: nil)
        collectionView.register(secondNib, forCellWithReuseIdentifier: "SecondCollectionViewCell")
        let secondHeaderNib = UINib(nibName: "SecondHeaderCollectionReusableView", bundle: nil)
        collectionView.register(secondHeaderNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "SecondHeaderCollectionReusableView")
    }
    
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .firstItem:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as? FirstCollectionViewCell else {
                    return UICollectionViewCell()
                }
                return cell
                
            case .twoItem(let int):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.label.text = String(int)
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = {[weak self] (collectionView: UICollectionView, elementKind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard elementKind == UICollectionView.elementKindSectionHeader else { return nil }

            // 두 번째 섹션에만 헤더를 표시
            if let view = collectionView.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: "SecondHeaderCollectionReusableView", for: indexPath) as? SecondHeaderCollectionReusableView {
                return view
            }
            
            return nil
        }
    }
    
    func configureSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.first, .second])
        snapshot.appendItems([tempFirstItem], toSection: .first)
        snapshot.appendItems(tempSecondItems, toSection: .second)
        dataSource.apply(snapshot)
    }
}

extension ViewController {
    func createBasicListLayout(viewType: ViewType) -> UICollectionViewCompositionalLayout {
        switch viewType {
        case .full: return createBasicFullListLayout()
        case .half: return createBasicHalfListLayout()
        case .halfEnd: return .init(section: createHalfSectionLayout())
        }
    }
    
    func createBasicFullListLayout() -> UICollectionViewCompositionalLayout {
        return .init { [weak self] section, environment in
            switch section {
            case 0: return self?.createFirstSectionLayout()
            default: return self?.createSecondSectionLayout(environment: environment)
            }
        }
    }
    
    func createFirstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createSecondSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerHeight = environment.container.effectiveContentSize.height - 44
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(headerHeight))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }

    func createBasicHalfListLayout() -> UICollectionViewCompositionalLayout {
        return .init { [weak self] section, environment in
            switch section {
            case 0: return self?.createHalfFirstSectionLayout(environment: environment)
            default: return self?.createHalfSectionLayout()
            }
        }
    }
    
    
    func createHalfFirstSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func createHalfSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(300))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }

}


