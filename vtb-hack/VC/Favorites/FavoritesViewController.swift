//
//  FovaritesViewController.swift
//  vtb-hack
//
//  Created by Semyon on 09.10.2020.
//

import UIKit

class FavoritesViewController: UIViewController {
    public enum PublicSpec {
        static let cvSideOffset: CGFloat = 20
    }

    let layout = UICollectionViewFlowLayout() ~> {
        $0.sectionInset = UIEdgeInsets(
            top: 10, left: PublicSpec.cvSideOffset,
            bottom: 10, right: PublicSpec.cvSideOffset
        )
        $0.minimumLineSpacing = 10
    }

    private lazy var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout) ~> {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.alwaysBounceVertical = true
        $0.register(CarCell.self, forCellWithReuseIdentifier: "CarCell")
//        $0.register(CurrencyCell.self, forCellWithReuseIdentifier: "CurrencyCell")
//        $0.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
//        $0.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        view.backgroundColor = Color.primary
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Избранное"
        navigationController?.extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 // TinderViewController.cardModels.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as? CarCell else { return UICollectionViewCell() }
        // cell.setup(title: TinderViewController.cardModels[indexPath.row].name)
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(
            width: collectionViewWidth - PublicSpec.cvSideOffset * 2,
            height: 0 // CarCell.getHeight(title: TinderViewController.cardModels[indexPath.row].name)
        )
    }
}
