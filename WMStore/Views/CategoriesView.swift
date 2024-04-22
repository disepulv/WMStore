//
//  CategoriesView.swift
//  WMStore
//
//  Created by Diego Sepulveda on 19-04-24.
//

import SwiftUI

struct CategoriesView: View {
    
    @AppStorage("selectedCategory") var selectedCategory: String = ""

    @ObservedObject var viewModel: CategoriesViewModel

    @Binding var showCategories: Bool
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.categories ?? [], id: \.self) { category in
                    HStack{
                        Text(category)
                        Spacer()
                        if selectedCategory == category {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if self.selectedCategory != category {
                            self.selectedCategory = category
                        } else {
                            self.selectedCategory = ""
                        }
                        showCategories = false
                    }
                }
            }

            if viewModel.categories == nil {
                ProgressView {
                    Text("Loading...")
                }
            }
            
        }
        .onAppear {
            viewModel.fetchCategories()
        }
        .navigationTitle("Categories")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showCategories = false
                } label: {
                    Image(systemName: "xmark.circle")
                }
            }
        }
    }
}

#Preview {
    CategoriesView(selectedCategory: "electronics", 
                   viewModel: CategoriesViewModel(),
                   showCategories: .constant(true))
}
