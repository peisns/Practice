// 기본형태

////
////  ViewController.swift
////  diffable
////
////  Created by air on 5/21/25.
////
//
//import UIKit
//
//class ViewController: UIViewController {
//    enum Section: Hashable {
//        case first
//    }
//    
//    enum Item: Hashable {
//        case firstItem(Int)
//    }
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    // 3. dataSource 인스턴스 정의
//    var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
//    var tempItems = (0..<30).map { Item.firstItem($0) }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configureCollectionView()
//    }
//    
//    func configureCollectionView() {
//        // 1. layout 등록. "셀들을 어떻게"
//        collectionView.collectionViewLayout = createBasicListLayout()
//        // 2. 셀 등록 "어떤 셀들을 사용할건가?"
//        let firstNib = UINib(nibName: "FirstCollectionViewCell", bundle: nil)
//        collectionView.register(firstNib, forCellWithReuseIdentifier: "FirstCollectionViewCell")
//        // 4. dataSource 할당 "Data와 Cell을 매치시키기"
//        configureDataSource()
//        // 5. snapshot 적용, "어떤 데이터를 사용할 것인가"
//        configureSnapshot()
//    }
//    
//    func configureDataSource() {
//        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as? FirstCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            if case let .firstItem(int) = itemIdentifier {
//                cell.label.text = String(int)
//            }
//            return cell
//        })
//    }
//    
//    func configureSnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
//        snapshot.appendSections([.first])
//        snapshot.appendItems(tempItems, toSection: .first)
//        dataSource.apply(snapshot)
//    }
//}
//
//extension ViewController {
//    func createBasicListLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                             heightDimension: .fractionalHeight(1.0))
//        
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//      
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .absolute(44))
//        
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                         subitems: [item])
//      
//        let section = NSCollectionLayoutSection(group: group)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
//}
//
//
