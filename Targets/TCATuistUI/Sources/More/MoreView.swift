//
//  MoreView.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/03.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Feature domain
struct MoreFeature: ReducerProtocol {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var items: [MoreEntity] = []
    }
    
    enum Action: Equatable {
        case goToDetail
        case path(StackAction<Path.State, Path.Action>)
        case onAppear
        case moreResponse(TaskResult<[MoreEntity]>)
    }
    
    @Dependency(\.moreClient) var moreClient
    private enum CancelID { case search }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .goToDetail:
                state.path.append(.detail())
                return .none
            case .onAppear:
                return .run { send in
                    await send(.moreResponse(TaskResult { try await self.moreClient.fetch() }))
                }
                .cancellable(id: CancelID.search)
            case let .moreResponse(.success(items)):
                state.items = items
                return .none
                
            case let .moreResponse(.failure(error)):
                // NB: This is where you could do some error handling.
                print(error)
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .detail(.screenButtonTapped)):
                    state.path.append(.detail())
                    return .none
                default:
                    return .none
                }
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
    
    struct Path: ReducerProtocol {
        enum State: Codable, Equatable, Hashable {
            case detail(MoreDetailFeature.State = .init())
        }
        
        enum Action: Equatable {
            case detail(MoreDetailFeature.Action)
        }
        
        var body: some ReducerProtocol<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                MoreDetailFeature()
            }
        }
    }
}

// MARK: - Feature view
struct MoreView: View {
    let store: StoreOf<MoreFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    List(viewStore.items) { item in
                        NavigationLink(destination: MoreDetailView(
                            store: Store(initialState: MoreDetailFeature.State(),
                                         reducer: MoreDetailFeature())
                        )) {
                            Text(item.title)
                        }
                    }
                }
                .onAppear { self.store.send(.onAppear) }
                .navigationBarTitle("More", displayMode: .inline)
            }
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView(
            store: Store(initialState: MoreFeature.State(), reducer: MoreFeature())
        )
    }
}
