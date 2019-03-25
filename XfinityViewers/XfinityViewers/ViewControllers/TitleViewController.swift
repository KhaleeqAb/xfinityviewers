//
//  TitleViewController.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/24/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import UIKit

protocol CharacterSelectionDelegate: class {
    func characterSelected(_ character: RelatedTopic)
}

class TitleViewController: UIViewController, UISplitViewControllerDelegate {
    
    var viewersViewModel: ViewersViewModel!
    weak var delegate: CharacterSelectionDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 40)
        return listLayout
    }()
    
    lazy var gridLayout: GridLayout = {
        var gridLayout = GridLayout(numberOfColumns: 3)
        return gridLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "XV_NavBarTitle".localizedString()
        viewersViewModel = ViewersViewModel()
        setupData()
    }
    
    func setupData() {
        splitViewController?.delegate = self
        viewersViewModel.getCharacters { [weak self] (error, charactersInfo) in
            guard charactersInfo != nil else {
                error?.printDescription()
                return
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self?.setupiPadView()
                }
            }
        }
        collectionView.collectionViewLayout = listLayout
        collectionView.register(UINib.init(nibName: listNibname, bundle: nil), forCellWithReuseIdentifier: listReuseId)
        collectionView.register(UINib.init(nibName: gridNibname, bundle: nil), forCellWithReuseIdentifier: gridReuseId)
    }
    
    func setupiPadView() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        self.collectionView(self.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        self.toggleSwitch.isHidden = true
    }
    
    @IBAction func switchLayout(layoutToggle: UISwitch) {
        
        activityIndicator.isHidden = false
        
        if(layoutToggle.isOn) {
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listLayout, animated: false)
            })
        } else {
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.gridLayout, animated: false)
            })
        }
        collectionView.reloadData()
        activityIndicator.isHidden = true
    }
}

extension TitleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: collectionView methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewersViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.collectionViewLayout == listLayout {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listReuseId, for: indexPath) as? ListCollectionViewCell ?? ListCollectionViewCell()
            cell.listLabel.text = viewersViewModel.getTitleForRow(row: indexPath.row)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridReuseId, for: indexPath) as? GridCollectionViewCell ?? GridCollectionViewCell()
            if let url = viewersViewModel.getImageURLForRow(row: indexPath.row) {
                cell.gridImageView.loadImageUsingUrlString(urlString: url)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCharacter = viewersViewModel.getRelatedTopicForRow(row: indexPath.row) else {
            return
        }
        delegate?.characterSelected(selectedCharacter)
        if let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            switch collectionView.collectionViewLayout {
            case listLayout:
                detailViewController.detailImageView.loadImageUsingUrlString(urlString: selectedCharacter.icon.url)
            case gridLayout:
                detailViewController.set(image: (collectionView.cellForItem(at: indexPath) as! GridCollectionViewCell).gridImageView.image)
            default: break
            }
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
