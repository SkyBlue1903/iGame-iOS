//
//  ProfileView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 29/09/22.
//


import SwiftUI

struct ProfileView: View {
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6759886742, green: 0.9469802976, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: .top, endPoint: .bottom)

      LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)).opacity(0.6), Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)).opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)

      ZStack {
        Circle()
                .frame(width: 400, height: 400)
                .offset(x: 150, y: -200)
                .foregroundColor(Color.purple.opacity(0.6))
                .blur(radius: 8)
        Circle()
                .frame(width: 300, height: 300)
                .offset(x: -100, y: -125)
                .foregroundColor(Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(1))
                .blur(radius: 8)

        PopupView()
      }

    }
            .edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct PopupView: View {
  var body: some View {
    ZStack(alignment: .topLeading) {
      Color.white.opacity(0.5)
              .frame(width: 360, height: 600)
              .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
              .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
              .blur(radius: 1)

      VStack(alignment: .center, spacing: 16) {
        Image("erlanggaanugrah")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .shadow(radius: 10)

        Text("Erlangga Anugrah Arifin")
                .font(.system(size: 24, weight: .bold, design: .rounded))

        Text("angga1433@gmail.com")
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .bold, design: .rounded))

        Text("Mahasiswa Teknik Informatika semester 5 di Universitas Dian Nuswantoro Semarang")
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .bold, design: .rounded))

        Text("Memiliki ketertarikan dunia komputer sejak kecil, terjun dibidang iOS sejak masuk kuliah, juga bercita-cita menjadi iOS developer dan berkarier di perusahaan ternama.\n\n Melanjutkan studi di perusahaan MyEduSolve bagian iOS Developer dengan program Studi Independen Kampus Merdeka.")
                .multilineTextAlignment(.center)
                .font(.footnote)

        Text("Sosial Media")
                .fontWeight(.bold)
                .font(.subheadline)

        HStack {
          Button(action: {
            if let url = URL(string: "https://facebook.com/angga1433") {
              UIApplication.shared.open(url)
            }
          }) {
            Image("facebookLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 10)
          }

          Spacer()
          Button(action: {
            if let url = URL(string: "https://instagram.com/anugrahangga") {
              UIApplication.shared.open(url)
            }
          }) {
            Image("instagramLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 10)
          }

          Spacer()
          Button(action: {
            if let url = URL(string: "https://www.linkedin.com/in/erlangga-anugrah-arifin-092a9218b/") {
              UIApplication.shared.open(url)
            }
          }) {
            Image("linkedInLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 10)
          }


          Spacer()
          Button(action: {
            if let url = URL(string: "https://twitter.com/Erlangga1903") {
              UIApplication.shared.open(url)
            }
          }) {
            Image("twitterLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                    .shadow(radius: 10)
          }
        }
                .padding(.horizontal, 10.0)
      }
              .padding()
              .frame(width: 360, height: 600)
              .foregroundColor(Color.black.opacity(0.8))

    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
