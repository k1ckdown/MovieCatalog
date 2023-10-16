//
//  ContentView.swift
//  Movies
//
//  Created by Ivan Semenov on 14.10.2023.
//

import SwiftUI

struct ContentView: View {

    let network = NetworkService()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .task {
            do {
//                let cred: LoginCredentials = .init(username: "user2023", password: "123456")
//                try await network.login(credentials: cred)
//                let profile = try await network.fetchProfile(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InVzZXIyMDIzIiwiZW1haWwiOiJ0ZXN0Nzc3QGdtYWlsLmNvbSIsIm5iZiI6MTY5NzQ2ODg4MCwiZXhwIjoxNjk3NDcyNDgwLCJpYXQiOjE2OTc0Njg4ODAsImlzcyI6Imh0dHBzOi8vcmVhY3QtbWlkdGVybS5rcmVvc29mdC5zcGFjZS8iLCJhdWQiOiJodHRwczovL3JlYWN0LW1pZHRlcm0ua3Jlb3NvZnQuc3BhY2UvIn0.EXhrKbtkqFjYt8Cg0XxHfd4DGLnZrWgaKkipE3mVblk")
//                print(profile)
                let movies = try await network.fetchFavoriteMovies(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InVzZXIyMDIzIiwiZW1haWwiOiJ0ZXN0Nzc3QGdtYWlsLmNvbSIsIm5iZiI6MTY5NzQ2ODg4MCwiZXhwIjoxNjk3NDcyNDgwLCJpYXQiOjE2OTc0Njg4ODAsImlzcyI6Imh0dHBzOi8vcmVhY3QtbWlkdGVybS5rcmVvc29mdC5zcGFjZS8iLCJhdWQiOiJodHRwczovL3JlYWN0LW1pZHRlcm0ua3Jlb3NvZnQuc3BhY2UvIn0.EXhrKbtkqFjYt8Cg0XxHfd4DGLnZrWgaKkipE3mVblk")
                print(movies.movies.count)
                print(movies.movies)
//                try await network.deleteFavoriteMovie(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InVzZXIyMDIzIiwiZW1haWwiOiJ0ZXN0Nzc3QGdtYWlsLmNvbSIsIm5iZiI6MTY5NzQ2ODg4MCwiZXhwIjoxNjk3NDcyNDgwLCJpYXQiOjE2OTc0Njg4ODAsImlzcyI6Imh0dHBzOi8vcmVhY3QtbWlkdGVybS5rcmVvc29mdC5zcGFjZS8iLCJhdWQiOiJodHRwczovL3JlYWN0LW1pZHRlcm0ua3Jlb3NvZnQuc3BhY2UvIn0.EXhrKbtkqFjYt8Cg0XxHfd4DGLnZrWgaKkipE3mVblk", movieId: "388cd8ec-5cb7-4e8b-a2ae-08d9b9f3d2a2")
//                print("success")
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
