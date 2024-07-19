//
//  StringUtil.swift
//  InstagramClone
//
//  Created by nandawperdana on 19/07/24.
//

func extractUsername(from email: String) -> String? {
    let component = email.components(separatedBy: "@")
    guard component.count > 1 else {
        return nil
    }
    return component.first
}
