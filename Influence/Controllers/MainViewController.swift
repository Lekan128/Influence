//
//  MainViewController.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 08/01/2023.
//

import UIKit
import Firebase

class MainViewController: UIViewController{
    
    @IBOutlet weak var addSongButton: UIButton!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
    var songs : [Song] = []
    
    override func viewWillAppear(_ animated: Bool) {
        addSongButton.isHidden = true
        startLoading(activityIndicatorView: mainActivityIndicator)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSongs()
        
        mainTableView.dataSource = self
        
        refisterNibWithMainTableView()
        
        
        if let uid = Auth.auth().currentUser?.uid{
            showAddButtonIfUserIsAdmin(with: uid)
        }else{
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
    func refisterNibWithMainTableView() {
        let uINib = UINib(nibName: k.mainSongCellNibName, bundle: nil)
        mainTableView.register(uINib, forCellReuseIdentifier: k.mainSongCellIdentifier)
//        mainTableView.register(SongCell.self, forCellWithReuseIdentifier: k.mainSongCellIdentifier)
//        mainTableView.register(SongCell.self, forCellReuseIdentifier:  k.mainSongCellIdentifier)

    }
    
    func showAddButtonIfUserIsAdmin(with uid : String) {
        FirebaseRef.getUserReference(userId: uid).getDocument(as: User.self) { result in
            switch result{
            case .success(let user):
                if user.isAdmin{
                    DispatchQueue.main.async {
                        self.addSongButton.isHidden = false
                    }
                }
            case.failure(let error):
                showDismissableAlert(with: error.localizedDescription, from: self)
            }
        }
    }
    
    func getSongs() {
        FirebaseRef.getSongReference()
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error{
                    showDismissableAlert(with: e.localizedDescription, from: self)
                    stopLoading(activityIndicatorView: self.mainActivityIndicator)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    showDismissableAlert(with: "A problem occoured", from: self)
                    stopLoading(activityIndicatorView: self.mainActivityIndicator)
                    return
                }
                for doc in documents{
                    do {
                        let song = try doc.data(as: Song.self)
                        self.songs.append(song)
                        
                    } catch let error{
                        showDismissableAlert(with: error.localizedDescription, from: self)
                        return
                    }
                }
                
//                print(self.songs)
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    stopLoading(activityIndicatorView: self.mainActivityIndicator)

                }
                
                //show songs
                
            }
    }
    
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: k.mainSongCellIdentifier, for: indexPath) as! SongCell
        
        let completeCell = mapSongToMainSongCell(song: song, cell: cell)
        return completeCell
        
    }
    
    func mapSongToMainSongCell(song : Song, cell : SongCell) -> SongCell {
        cell.artistNameLabel.text = song.artist
        cell.songNameLabel.text = song.name
        cell.setProgrss(influenceresWorked: song.influencersWorked, totalInflencersNeeded: song.influencersNeeded)
        return cell
    }
    
}
