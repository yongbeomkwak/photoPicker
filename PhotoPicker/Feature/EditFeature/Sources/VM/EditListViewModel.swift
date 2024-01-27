//
//  EditListViewModel.swift
//  PhotoPicker
//
//  Created by yongbeomkwak on 1/26/24.
//

import Foundation
import Combine

enum RotateState : Int {
    
    case none = -1
    case vertical = 0
    case horizontal
    case flipVertical
    case flipHorizontal
    
    func next() -> RotateState {
        
        if self == .none {
            return .vertical
        }
        
        return RotateState(rawValue:(self.rawValue+1)%4)!
    }
    
}

final class EditListViewModel : ViewModelType {

    var dataes:[Data?]
    
    var subscription: Set<AnyCancellable> = .init()
    
    var rotateState: [RotateState]
    
    init(dataes: [Data?]) {
        self.dataes = dataes
        self.rotateState = [RotateState](repeating: .none, count: dataes.count)
    }
    
    deinit {
        DEBUG_LOG("❌ \(Self.self)")
    }
    
    struct Input {
        let tapCrop : AnyPublisher<Void, Never>
        let tapRotate : AnyPublisher<Void, Never>
        let index = CurrentValueSubject<Int, Never>(0)
    }
    
    struct Output {
        let rotate: AnyPublisher<Int, Never>
        let selelctedData: AnyPublisher<Data?, Never>
    }
    
    func transform(input: Input) -> Output {
        
        var outputRotateSubject = CurrentValueSubject<Int,Never>(0)
        var outputSelelctedDataSubject = PassthroughSubject<Data?, Never>()
        
        input.tapCrop
            .sink { [weak self] _ in
                guard let self else {return}
                outputSelelctedDataSubject.send(self.dataes[input.index.value])
            }
            .store(in: &subscription)
        
        
        
        input.tapRotate
            .map{input.index.value}
            .sink(receiveValue: { (index:Int) in
                DEBUG_LOG("\(index)")
                outputRotateSubject.send(index)
            })
            
            .store(in: &subscription)
        
        
        
        return Output(rotate: outputRotateSubject.eraseToAnyPublisher(), selelctedData: outputSelelctedDataSubject.eraseToAnyPublisher())
    }
    
}
