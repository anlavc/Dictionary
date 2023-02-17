//
//  HeaderDetailView.swift
//  Dictionary
//
//  Created by Anıl AVCI on 7.02.2023.
//

import UIKit
import AVFoundation


class CustomHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    private var collectionCell = "collectionCell"
    var headerCellItems = ["Noun", "Verb", "Adjective", "Adverb"]
    var audioPlayer: AVPlayer?
    var audio: String?
    var audioWord: String?
    var isRed = false
        var progressBarTimer: Timer!
        var isRunning = false
    @IBOutlet weak var progressBar: UIProgressView!
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        configureHeaderView()
      
    }
    private func playAudioFromURL() {
        guard let url = URL(string: audioWord ?? "yok") else {
            print("error to get the mp3 file")
            return
        }
        do {
            audioPlayer = try AVPlayer(url: url as URL)
        } catch {
            print("audio file error")
        }
        audioPlayer?.play()
    }



    private func configureHeaderView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: collectionCell)
        soundButton.layer.shadowColor = UIColor.black.cgColor
        soundButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        soundButton.layer.masksToBounds = false
        soundButton.layer.shadowRadius = 2.0
        soundButton.layer.shadowOpacity = 0.5
        soundButton.layer.cornerRadius = soundButton.frame.width / 2
    }
    @IBAction func soundButtonPressed(_ sender: UIButton) {
      playAudioFromURL()
    }
    
}
extension CustomHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerCellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCell, for: indexPath) as? HeaderCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell()}
        cell.label.text =  headerCellItems[indexPath.row]
        return cell
    }
}
extension CustomHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimensions = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimensions - 10, height: itemDimensions)
    }
    
}
