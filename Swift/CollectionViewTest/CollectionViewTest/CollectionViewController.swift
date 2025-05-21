//
//  CollectionViewController.swift
//  CollectionViewTest
//
//  Created by buildbook on 3/20/25.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private weak var scrollViewInCell: UIScrollView?
    private var innerScrollingDownDueToOuterScroll = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }

}

//MARK: private method
extension CollectionViewController {
    private func configure() {
        view.backgroundColor = .systemPink
        configureNavigationController()
        configureCollectionView()
    }
    private func configureNavigationController() {
        configureNavigationControllerAppearance()
        configureRightBarButtonItem()
    }
    private func configureNavigationControllerAppearance() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "CollectionView"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    private func configureRightBarButtonItem() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.forward.app"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareButtonClicked))
        // 내비게이션 바 오른쪽에 여러 개의 버튼 추가
        navigationItem.rightBarButtonItem = shareButton
    }
    @objc private func shareButtonClicked() {
        let ac = UIAlertController(title: nil, message: "share Button Clicked", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        ac.addAction(ok)
        present(ac, animated: false)
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: "FirstCell")
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: "SecondCell")
        collectionView.register(ThirdHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ThirdHeaderView")
        collectionView.register(ThirdCell.self, forCellWithReuseIdentifier: "ThirdCell")
        collectionView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
//            layout.sectionHeadersPinToVisibleBounds = true
            return layout
        }()
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 { return CGSize(width: view.bounds.size.width, height: 40) }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width,
            height = view.frame.height
        switch indexPath.section {
        case 0, 1: return CGSize(width: width, height: 44+54)
        case 2:
            let innerHeight: CGFloat = height - 40
            - (navigationController?.navigationBar.frame.height ?? 0)
            - (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
            - ((UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.bottom ?? 0)
            return CGSize(width: width,
                          height: innerHeight)
        default: return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 2 {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ThirdHeaderView", for: indexPath) as? ThirdHeaderView else {
                return UICollectionReusableView()
            }
            return view
        }
        return UICollectionReusableView()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as? FirstCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as? SecondCell else {
                return UICollectionViewCell()
            }
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as? ThirdCell else {
                return UICollectionViewCell()
            }
            scrollViewInCell = cell.scrollViewInCell
            cell.scrollViewInCell.delegate = self
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let remainingScrollHeight = scrollView.contentSize.height - scrollView.frame.size.height
            let isBottomReached = scrollView.contentOffset.y >= remainingScrollHeight
            guard let scrollViewInCell else { return }
            scrollViewInCell.isScrollEnabled = isBottomReached
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let outerScroll = collectionView == scrollView
//        let innerScroll = !outerScroll
//        // scrollview의 pan(드래그) 제스처의 translation이동이 0보다 작은가? -> (-)방향인가? -> 손가락을 위로 올리는 스크롤링의 Bool값(아래 콘텐츠 확장)
//        let moreScroll = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
//        let lessScroll = !moreScroll
//        
//        guard let scrollViewInCell else { return }
//        // 바깥 collectionView의 y가 최대일 수 있는 값
//        let outerScrollMaxOffsetY = collectionView.contentSize.height - collectionView.frame.height
//        let innerScrollMaxOffsetY = scrollViewInCell.contentSize.height - scrollViewInCell.frame.height
//        
//        // scrollview가 collectionView이고, 아래로 더 당겨와야 한다면
//        if outerScroll && moreScroll {
//            // collectionview offset y가 collection뷰의 콘텐츠 오프셋 y과 같거나 작을 때 작동
//            guard outerScrollMaxOffsetY < collectionView.contentOffset.y + 0.1 else { return }
//            
//            innerScrollingDownDueToOuterScroll = true
//            defer { innerScrollingDownDueToOuterScroll = false }
//            
//            // innerScrollView를 모두 스크롤 한 경우 stop
//            guard scrollViewInCell.contentOffset.y < innerScrollMaxOffsetY else { return }
//            
//            scrollViewInCell.contentOffset.y = scrollViewInCell.contentOffset.y + collectionView.contentOffset.y - outerScrollMaxOffsetY
//            collectionView.contentOffset.y = outerScrollMaxOffsetY
//        }
//
//        if outerScroll && lessScroll {
//            guard scrollViewInCell.contentOffset.y > 0
//                    && collectionView.contentOffset.y < outerScrollMaxOffsetY else { return }
//            
//            innerScrollingDownDueToOuterScroll = true
//            defer { innerScrollingDownDueToOuterScroll = false }
//            
//            // outer scroll에서 스크롤한 만큼 inner scroll에 적용
//            scrollViewInCell.contentOffset.y = max(scrollViewInCell.contentOffset.y - (outerScrollMaxOffsetY - collectionView.contentOffset.y), 0)
//            
//            // outer scroll은 스크롤 되지 않고 고정
//            collectionView.contentOffset.y = outerScrollMaxOffsetY
//        }
//
//        if innerScroll && lessScroll {
//            defer { scrollViewInCell.lastOffsetY = scrollViewInCell.contentOffset.y }
//            guard scrollViewInCell.contentOffset.y < 0 && collectionView.contentOffset.y > 0 else { return }
//            
//            // innerScrollView의 bounces에 의하여 다시 outerScrollView가 당겨질수 있으므로 bounces로 다시 되돌아가는 offset 방지
//            guard scrollViewInCell.lastOffsetY > scrollViewInCell.contentOffset.y else { return }
//            
//            let moveOffset = outerScrollMaxOffsetY - abs(scrollViewInCell.contentOffset.y) * 3
//            guard moveOffset < collectionView.contentOffset.y else { return }
//            
//            collectionView.contentOffset.y = max(moveOffset, 0)
//        }
//
//        if innerScroll && moreScroll {
//            guard
//                collectionView.contentOffset.y + 0.1 < outerScrollMaxOffsetY,
//                !innerScrollingDownDueToOuterScroll
//            else { return }
//            // outer scroll를 more 스크롤
//            let minOffetY = min(collectionView.contentOffset.y + scrollViewInCell.contentOffset.y, outerScrollMaxOffsetY)
//            let offsetY = max(minOffetY, 0)
//            collectionView.contentOffset.y = offsetY
//            
//            // inner scroll은 스크롤 되지 않아야 하므로 0으로 고정
//            scrollViewInCell.contentOffset.y = 0
//        }
//
//    }
}

private struct AssociatedKeys {
    static var lastOffsetY = "lastOffsetY"
}

extension UIScrollView {
    var lastOffsetY: CGFloat {
        get {
            (objc_getAssociatedObject(self, &AssociatedKeys.lastOffsetY) as? CGFloat) ?? contentOffset.y
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lastOffsetY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


////MARK: UIScrollViewDelegate
//extension CollectionViewController: UIScrollViewDelegate {
//    // 컬렉션 뷰의 content offset.y가 (전체 컨텐츠 사이즈 - 컬렉션뷰 높이 = 최대로 내릴 수 있는 contentOffset.y )를 넘어가지 않도록 조정해서 하단 bounce 고정
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 0 {
//            if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height {
//                scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.frame.height
//            }
//        }
//        
////        // 마지막에 도착하면 셀 스크롤 켜기
////        if scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.height {
////            let view = scrollView as! UICollectionView
////            guard let cell = view.cellForItem(at: IndexPath(item: 0, section: 2)) as? ThirdCell else { return }
////        }
//        
//        //위로 올라가면 셀 스크롤 끄기
////        if scrollView.contentOffset.y < scrollView.contentSize.height - scrollView.frame.height {
////            let view = scrollView as! UICollectionView
////            guard let cell = view.cellForItem(at: IndexPath(item: 0, section: 2)) as? ThirdCell else { return }
////        }
//    }
//}



class FirstCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class SecondCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .orange
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ThirdHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ThirdCell: UICollectionViewCell {
    
    let scrollViewInCell: UIScrollView = {
        let view = UIScrollView()
        view.bounces = false
        view.isScrollEnabled = false
        return view
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = "label1"
        return label
    }()
    let label2: UILabel = {
        let label = UILabel()
        label.text = "label2"
        return label
    }()
    let label3: UILabel = {
        let label = UILabel()
        label.text = "label3"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        configure()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        contentView.addSubview(scrollViewInCell)
        scrollViewInCell.translatesAutoresizingMaskIntoConstraints = false
        scrollViewInCell.backgroundColor = .systemGray5
        
        [label1, label2, label3].forEach {
            scrollViewInCell.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollViewInCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollViewInCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollViewInCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollViewInCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            label1.leadingAnchor.constraint(equalTo: scrollViewInCell.leadingAnchor, constant: 16),
            label1.topAnchor.constraint(equalTo: scrollViewInCell.topAnchor, constant: 40),
            
            label2.leadingAnchor.constraint(equalTo: scrollViewInCell.leadingAnchor, constant: 16),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 500),
            
            label3.leadingAnchor.constraint(equalTo: scrollViewInCell.leadingAnchor, constant: 16),
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 500),
            label3.bottomAnchor.constraint(equalTo: scrollViewInCell.bottomAnchor)
        ])
        
    }
}
