import ComposableArchitecture
import SwiftUI
import SwiftUIHelpers

public struct ContentView: View {
  let store: StoreOf<ContentReducer>

  public init(
    store: StoreOf<ContentReducer>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store) { _ in
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(alignment: .leading) {
          Color.red
            .frame(height: 400)
            .cornerRadius(22)
            .padding(.top, 60)

          Spacer().frame(height: 32)

          HStack(spacing: 12) {
            Color.blue
              .frame(width: 40, height: 40)
              .cornerRadius(6)

            VStack {
              Text("tomokisun")
                .bold()
              Text("2hours ago")
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }

          Spacer().frame(height: 12)

          Text("I bought it because it's freemint at ZORA, but it's probably not very pretty.")
            .font(.title3)
            .bold()
          
          Spacer().frame(height: 12)
          
          Text("🌎 ZORA")
            .frame(width: 96, height: 36)
            .background(Color.systemGray6)
            .cornerRadius(24)
          
          Spacer().frame(height: 32)
          
          AboutDigitalCollectiveView()
          
          Color.blue
            .frame(height: 2000)
            .frame(maxWidth: .infinity)
        }
      }
      .frame(width: 312)
    }
  }
}

struct ContentViewPreview: PreviewProvider {
  static var previews: some View {
    Preview {
      ContentView(
        store: .init(
          initialState: ContentReducer.State(),
          reducer: ContentReducer()
        )
      )
    }
  }
}
