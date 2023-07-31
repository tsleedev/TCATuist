//
//  MoreDetailView.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/07.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Feature domain
struct MoreDetailFeature: ReducerProtocol {
    struct State: Codable, Equatable, Hashable {
        
    }
    
    enum Action: Equatable {
        case screenButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .screenButtonTapped:
            return .none
        }
    }
}

struct MoreDetailView: View {
    let store: StoreOf<MoreDetailFeature>
    
    var body: some View {
        Text("DetailView")
    }
}

struct MoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoreDetailView(
            store: Store(initialState: MoreDetailFeature.State(), reducer: MoreDetailFeature())
        )
    }
}
