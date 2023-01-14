//
//  AddSongViewController.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 09/01/2023.
//

import UIKit
import Firebase

class AddSongViewController: UIViewController {
    
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var noOfInfluencersTextField: UITextField!
    @IBOutlet weak var songLinksTextView: UITextView!
    @IBOutlet weak var artistHandleTextField: UITextField!
    @IBOutlet weak var addSongActivityIndicator: UIActivityIndicatorView!
    
    var mUid : String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopLoading(activityIndicatorView: addSongActivityIndicator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uid = Auth.auth().currentUser?.uid{
            mUid = uid
        }else{
            showDismissableAlert(with: "Please Login", from: self)
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func addSongPressed(_ sender: UIButton) {
        guard  let artistName = artistNameTextField.text,
           let songTitle = songTitleTextField.text,
           let noOfInfluencersString = noOfInfluencersTextField.text,
           let artistHandle = artistNameTextField.text,
           let songLinks = songLinksTextView.text else{
            showDismissableActionSheet(with: "Fill all fields", from: self)
            return
        }
        
        startLoading(activityIndicatorView: addSongActivityIndicator)

        
        let songLinksListSubString = songLinks.split(separator: "\n")
        let songLinksList = songLinksListSubString.map { substring in
            return String(substring)
        }
        
        //Todo fix songLinksList
        if let noOfInf = Int(noOfInfluencersString){
            if(mUid.isEmpty){
                showDismissableAlert(with: "Please Login", from: self)
                _ = navigationController?.popToRootViewController(animated: true)
                return
            }
            
            let song = Song(songName: songTitle, artistName: artistName, links: songLinksList, influencersNeeded: noOfInf, artistHandle: artistHandle, addedBy: mUid)
            
            print(song)
            
            addSongToDatabase(song: song)
            
        }else{
            showDismissableAlert(with: "Input number", from: self)
            stopLoading(activityIndicatorView: addSongActivityIndicator)
        }
        
    }
    
    func addSongToDatabase(song s : Song) {
        let songDocRef = FirebaseRef.getSongReference().document()
        var song = s
        song.songId = songDocRef.documentID
        do{
            try songDocRef.setData(from: song)
            stopLoading(activityIndicatorView: addSongActivityIndicator)
            _ = navigationController?.popViewController(animated: true)
        } catch let error{
            showDismissableAlert(with: error.localizedDescription, from: self)
            stopLoading(activityIndicatorView: addSongActivityIndicator)
        }
        
    }
    
    
    
}
