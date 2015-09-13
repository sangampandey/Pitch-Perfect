//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Sangam Pandey on 9/13/15.
//  Copyright (c) 2015 Sangam Pandey. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl:NSURL,title:String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}