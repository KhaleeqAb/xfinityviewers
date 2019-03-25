//
//  DetailViewController.swift
//  XfinityViewers
//
//  Created by Khaleeq Abdul on 3/24/19.
//  Copyright © 2019 Xfinity. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedCharacter: RelatedTopic? {
        didSet {
            refreshUI()
        }
    }
    
    @IBOutlet weak var detailImageView: FetchImages!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        let topic = selectedCharacter?.text.splitStringWithSeparator(separator: "-")
        self.navigationItem.title = String(topic?.first ?? "")
        detailLabel.text = String(topic?.last ?? "")
    }
    
    func set(image: UIImage?) {
        detailImageView.image = image
    }
}

extension DetailViewController: CharacterSelectionDelegate {
    func characterSelected(_ character: RelatedTopic) {
        selectedCharacter = character
    }
}
