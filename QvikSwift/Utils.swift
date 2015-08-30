//
//  Utils.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 30/08/15.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation

func runInBackground(task: Void -> Void) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), task)
}

