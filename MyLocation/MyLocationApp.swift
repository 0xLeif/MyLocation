//
//  MyLocationApp.swift
//  MyLocation
//
//  Created by Leif on 7/20/22.
//

import CacheStore
import CoreLocation
import LocationCacheStore
import SwiftUI

var count: CGFloat {
    .random(in: 0 ... 100)
}

@main
struct MyLocationApp: App {
    @ObservedObject var store: Store<LocationStoreKey, Void, Void>
    @ObservedObject var locationStore: Store<LocationStoreKey, LocationStoreAction, LocationStoreDependency>
    
    init() {
        let store = Store<LocationStoreKey, Void, Void>(initialValues: [:], actionHandler: .none, dependency: ())
        self._store = ObservedObject(
            wrappedValue: store
        )
        self._locationStore = ObservedObject(
            wrappedValue: store.scope(
                keyTransformation: (
                    from: { $0 },
                    to: { $0 }
                ),
                actionHandler: locationStoreActionHandler(),
                dependencyTransformation: {
                    .init {
                        CLLocation(latitude: count, longitude: count)
                    }
                }
            )
            .debug
        )
    }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView(
                    store: store.actionlessScope(
                        keyTransformation: (
                            from: { $0 },
                            to: { $0 }
                        )
                    )
                )
                Button("Update") {
                    locationStore.handle(action: .updateLocation)
                }
            }
            .onAppear {
                locationStore.handle(action: .updateLocation)
            }
        }
    }
}
