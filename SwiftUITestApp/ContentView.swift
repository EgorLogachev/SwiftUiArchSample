//
//  ContentView.swift
//  SwiftUITestApp
//
//  Created by Yegor Logachev on 03.08.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Color? = nil
    var body: some View {
        NavigationView {
            HomeScreenView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// Home screen part
struct HomeScreenView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HomeNavigation(viewModel: viewModel)
            HomeLayout(viewModel: viewModel)
        }
    }
}

class HomeViewModel: ObservableObject {
    
    @Published var navTag: String?
    @Published var navArgs: Color?
    
    func navigateToRedScreen() {
        navArgs = Color.red
        navTag = "colorScreen"
    }
    
    func navigateToGreenScreen() {
        navArgs = Color.green
        navTag = "colorScreen"
    }
    
    func navigateToGrayScreen() {
        navArgs = Color.gray
        navTag = "colorScreen"
    }
}


struct HomeLayout: View {
    var viewModel: HomeViewModel
    var body: some View {
        VStack {
            Button(action: {
                viewModel.navigateToRedScreen()
            }, label: {
                Text("Red screen")
            })
            Button(action: {
                viewModel.navigateToGreenScreen()
            }, label: {
                Text("Green screen")
            })
            Button(action: {
                viewModel.navigateToGrayScreen()
            }, label: {
                Text("Gray screen")
            })
        }
    }
}

struct HomeNavigation: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            NavigationLink(
                destination: ColorBgScreenView(color: $viewModel.navArgs),
                tag: "colorScreen",
                selection: $viewModel.navTag
            ) {
                EmptyView()
            }
        }
    }
}



struct ColorBgScreenView: View {
    @Binding var color: Color?
    var body: some View {
        ColorBgLayout(color: $color)
    }
    
}

struct ColorBgLayout: View {
    @Binding var color: Color?
    var body: some View {
        ZStack {
            color?.ignoresSafeArea()
        }
    }
}

