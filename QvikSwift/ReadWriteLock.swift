//
//  ReadWriteLock.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 12.8.201533.
//  Copyright (c) 2015 Qvik. All rights reserved.
//

import Foundation

/**
Swift wrapper for pthread read/write lock, synchronization between threads to a resource.

The lock can be acquired for reading when there are no writers waiting for the lock
or owning the lock. 

The lock can be acquired for writing when there are no readers or other writers owning the lock.

Intending to use this class? You probably should see about redesigning
your code and / or using GCD.
*/
public class ReadWriteLock {
    var lock: pthread_rwlock_t
    
    /// Lock for reading. Blocks until the lock is acquired.
    public func lockToRead() {
        pthread_rwlock_rdlock(&lock)
    }

    /// Attempts to lock for reading; if unsuccessful, returns false.
    public func tryLockToRead() -> Bool {
        let res = pthread_rwlock_tryrdlock(&lock)
        return (res == 0)
    }
    
    /// Lock for writing. Blocks until the lock is acquired.
    public func lockToWrite() {
        pthread_rwlock_wrlock(&lock)
    }
    
    /// Attempts to lock for writing; if unsuccessful, returns false.
    public func tryLockToWrite() -> Bool {
        let res = pthread_rwlock_trywrlock(&lock)
        return (res == 0)
    }
    
    /// Unlocks the lock.
    public func unlock() {
        pthread_rwlock_unlock(&lock)
    }
    
    deinit {
        pthread_rwlock_destroy(&lock)
    }
    
    init() {
        lock = pthread_rwlock_t()
        pthread_rwlock_init(&lock, nil)
    }
}