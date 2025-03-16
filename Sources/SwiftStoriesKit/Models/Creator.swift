//
//  Creator.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import Foundation

public struct Creator {
    
   public let id: String
   public let email: String
   public let firstName: String
   public let lastName: String
   public let createdAt: Int64
   public let isVerified: Bool
    
    public init(
        id: String = "",
        email: String = "",
        firstName: String = "",
        lastName: String = "",
        createdAt: Int64 = 0,
        isVerified: Bool = false
    ) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = createdAt
        self.isVerified = isVerified
    }
}
