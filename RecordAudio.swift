//
//  RecordAudio.swift
//  Pitch Perfect
//
//  Created by Walter Black on 4/5/15.
//  Copyright (c) 2015 Walt Black. All rights reserved.
//

import Foundation

class RecordAudio: NSObject{
    var filePathURL: NSURL!
    var title: String!
    
    init(fileURL: NSURL!, title: String!) {
        self.filePathURL = fileURL
        self.title = title
    }
}
