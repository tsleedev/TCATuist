//
//  SearchView.swift
//  TCATuistUI
//
//  Created by TAE SU LEE on 2023/07/04.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Feature domain
struct SearchFeature: ReducerProtocol {
    struct State: Equatable {
        var query: String = ""
        var items: [SearchEntity] = []
    }
    
    enum Action: Equatable {
        case searchQueryChanged(String)
        case searchQueryChangeDebounced
        case searchResponse(TaskResult<SearchEntityItems>)
    }
    
    @Dependency(\.searchClient) var searchClient
    private enum CancelID { case search }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .searchQueryChanged(let query):
            state.query = query
            guard !query.isEmpty else {
              state.items = []
              return .cancel(id: CancelID.search)
            }
            return .none
            
        case .searchQueryChangeDebounced:
            guard !state.query.isEmpty else {
                return .none
            }
            return .run { [query = state.query] send in
                await send(.searchResponse(TaskResult { try await self.searchClient.fetch(query) }))
            }
            .cancellable(id: CancelID.search)
            
        case let .searchResponse(.success(items)):
            state.items = items.items
            return .none
            
        case let .searchResponse(.failure(error)):
            // NB: This is where you could do some error handling.
            print(error)
            return .none
        }
    }
}

// MARK: - Feature view
struct SearchView: View {
    let store: StoreOf<SearchFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    searchBar(viewStore)
                        .padding()
                    List {
                        ForEach(viewStore.items, id:\.id) {
                            if let fullName = $0.fullName {
                                Text(fullName)
                            }
                        }
                    }
                }
            }
        }
        ._printChanges()
    }
}

// MARK: - Subviews
private extension SearchView {
    func searchBar(_ viewStore: ViewStore<SearchFeature.State, SearchFeature.Action>) -> some View {
        Group {
            if #available(iOS 15.0, *) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: viewStore.binding(
                        get: \.query,
                        send: SearchFeature.Action.searchQueryChanged
                    ))
                    .foregroundColor(.primary)
                }
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                .task(id: viewStore.query) {
                    do {
                        try await Task.sleep(nanoseconds: NSEC_PER_SEC / 3)
                        DispatchQueue.main.async {
                            viewStore.send(.searchQueryChangeDebounced)
                        }
//                        await viewStore.send(.searchQueryChangeDebounced).finish()
                    } catch {}
                }
            } else {
                EmptyView()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            store: .init(
                initialState: SearchFeature.State(),
                reducer: SearchFeature() // ._printChanges()
            )
        )
    }
}
