//
//  HopoateAdapter.swift
//  Space Rescuer
//
//  Created by Oleksii on 11.05.2025.
//

import Foundation

func registerSingle<Service>(service: Service.Type,
                             creator: @escaping () -> Service) {
    
    _ = DependencyContainer.shared.register(service: service,
                                            cacheService: true,
                                            creator: creator)
}

func registerFactory<Service>(service: Service.Type,
                              creator: @escaping () -> Service) {
    
    _ = DependencyContainer.shared.register(service: service,
                                            cacheService: false,
                                            creator: creator)
}
