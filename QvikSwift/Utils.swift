// The MIT License (MIT)
//
// Copyright (c) 2015 Qvik (www.qvik.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/**
 Asynchronously executes a task in a background queue.
 
 - parameter task: Task to be executed
*/
public func runInBackground(task: (Void -> Void)) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), task)
}

/**
 Asynchronously executes a task in the main thread. If the calling thread is
 the main thread itself, the task is executed immediately.
 
 - parameter task: Task to be executed
*/
public func runOnMainThread(task: (Void -> Void)) {
    if NSThread.isMainThread() {
        // Already on main UI thread - call directly
        task()
    } else {
        dispatch_async(dispatch_get_main_queue(), task)
    }
}

/**
 Executes a task on the main queue (UI thread) after a given delay.
 
 - parameter delay: Delay in seconds
 - parameter task: Task to be executed
*/
public func runOnMainThreadAfter(delay delay: NSTimeInterval, task: (Void -> Void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),dispatch_get_main_queue(), task)
}
