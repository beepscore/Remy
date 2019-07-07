//
//  FileUtil.swift
//  Remy
//
//  Created by Steve Baker on 7/7/19.
//  Copyright © 2019 Beepscore LLC. All rights reserved.
//

import Foundation

struct FileUtil {

    static func baseFilename(path: String) -> String {

        let url = URL(fileURLWithPath: path)
        // https://stackoverflow.com/questions/39887738/remove-suffix-from-filename-in-swift
        let urlNoExtension = url.deletingPathExtension

        let base = urlNoExtension().lastPathComponent
        return base
    }
}
