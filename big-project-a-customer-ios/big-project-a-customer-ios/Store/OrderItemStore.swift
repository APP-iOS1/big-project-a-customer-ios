//
//  OrderItemStore.swift
//  big-project-a-customer-ios
//
//  Created by 전근섭 on 2023/01/03.
//

import Foundation
import SwiftUI
import Firebase


class OrderItemStore: ObservableObject {
    @Published var items: [OrderItemInfo] = []
}
