//
//  CounterView.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/03.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Feature domain
struct Counter: ReducerProtocol {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}

// MARK: - Feature view
struct CounterView: View {
    let store: StoreOf<Counter>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Button {
                    viewStore.send(.decrementButtonTapped)
                } label: {
                    Image(systemName: "minus")
                }
                
                Text("\(viewStore.count)")
//                    .monospacedDigit()
                
                Button {
                    viewStore.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialState: Counter.State()) {
                Counter()
            }
        )
    }
}
