//
//  Song.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 08/01/2023.
//

import Foundation

struct Song : Codable {
    var songId : String
    let name : String
    let artist : String
    let links : [String]
    let adderUid : String
    let artistHandle : String
    //add artist handle
    
    var influencersNeeded : Int
    var influencersWorked : Int
    
    init(songName name : String, artistName artist : String, links : [String], influencersNeeded infNeeded : Int,artistHandle : String, addedBy adderUid : String ) {
        songId = ""
        self.name = name
        self.artist = artist
        self.links = links
        self.adderUid = adderUid
        influencersNeeded = infNeeded
        influencersWorked = 0
        self.artistHandle = artistHandle
    }
    
    var prgress : Double {
        return (Double(influencersWorked) / Double(influencersNeeded))
    }
    
    mutating func increaseInfToWorkOnSong() {
        influencersNeeded += 1
    }
    

}
