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
    @ObservedObject var locationStore = LocationStore(
        dependency: LocationStoreDependency(
            updateLocation: {
                CLLocation(latitude: count, longitude: count)
            }
        )
    ).debug
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: locationStore.actionlessScope(
                    keyTransformation: (
                        from: { $0 },
                        to: { $0 }
                    ),
                    dependencyTransformation: { _ in () }
                )
            )
        }
    }
}
