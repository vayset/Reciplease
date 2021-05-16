//
//  FridgeServiceError.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 16/05/2021.
//

import Foundation

enum FridgeServiceError: Error {
    case failedToAddIngredientIsEmpty
    case failedToAddIngredientIsAlreadyAdded
    case failedToGetRecipesIngredientIsEmpty
    case failedToGetRecipesBackendError
    case couldNotCreateUrl
}
