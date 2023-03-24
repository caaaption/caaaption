import SwiftUI
import SwiftUIHelpers
import ComposableArchitecture

public struct ContentView: View {
  let store: StoreOf<ContentReducer>
  
  public init(
    store: StoreOf<ContentReducer>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      ScrollView(.vertical) {
        LazyVStack {
          Color.red
            .frame(height: 400)
            .cornerRadius(22)
          
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
          
          Text("First Yakiniku restaurant in the back of Center Street with Jinkun, thank you.🥰")
            .font(.title3)
            .bold()
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
