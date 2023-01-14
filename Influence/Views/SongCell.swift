//
//  SongCell.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 10/01/2023.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var songCellContentView: UIView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songCellProgressView: UIProgressView!
    @IBOutlet weak var songProgressFractionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        songCellContentView.layer.cornerRadius = songCellContentView.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setArtistName(artistName : String) {
        artistNameLabel.text = "By \(artistName)"
    }
    func setProgrss(influenceresWorked : Int, totalInflencersNeeded : Int) {
        _ = Float(influenceresWorked)
        songProgressFractionLabel.text = "\(influenceresWorked)/\(totalInflencersNeeded)"
        
        
        let infWorked = Float(influenceresWorked)
        let infNeeded = Float(totalInflencersNeeded)
        songCellProgressView.setProgress((infWorked/infNeeded), animated: true)
        
        
    }
}
