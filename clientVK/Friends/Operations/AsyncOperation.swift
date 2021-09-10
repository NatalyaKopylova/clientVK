//
//  AsyncOperation.swift
//  clientVK
//
//  Created by Natalia on 03.08.2021.
//

import Foundation

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + self.rawValue.capitalized
        }
    }
    
    private var state: State = State.ready {
        // Уведомляем систему KVO, о том что у нас изменились состояния в операции
        
        // Вызывается в момент установки значений
        willSet {
            self.willChangeValue(forKey: self.state.keyPath)
            self.willChangeValue(forKey: newValue.keyPath)
        }
        
        // Вызывается после установки значений
        didSet {
            self.didChangeValue(forKey: self.state.keyPath)
            self.didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && self.state == .ready
    }
    
    override var isExecuting: Bool {
        return self.state == .executing
    }
    
    override var isFinished: Bool {
        return self.state == .finished
    }
    
    override func start() {
        if self.isCancelled {
            self.state = .finished
        } else {
            self.main()
            self.state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        self.state = .finished
    }
    
    /// Set operation as finished
    /// - Tag: finished
    func finished() {
        self.state = .finished
    }
}
