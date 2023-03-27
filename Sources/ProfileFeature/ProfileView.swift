import SwiftUI
import SwiftUIHelpers
import ComposableArchitecture

public struct ProfileView: View {
  let store: StoreOf<ProfileReducer>
  
  public init(store: StoreOf<ProfileReducer>) {
    self.store = store
  }
  
  public var body: some View {
    ScrollView {
      Spacer().frame(height: 50)
      HStack {
        VStack(alignment: .leading) {
          Text("tomokisun")
            .font(.largeTitle)
            .bold()
          
          Spacer().frame(height: 4)
          
          Text("@tomokisun")
            .font(.caption)
            .bold()
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(6)
          
          Spacer().frame(height: 8)
          
          Text("Active 19m ago")
            .font(.caption2)
            .fontWeight(.medium)
        }
        .frame(height: 96)
        Spacer()
        Color.red
          .frame(width: 96, height: 96)
          .cornerRadius(22)
      }
    }
    .padding(.horizontal, 20)
  }
}

struct ProfileViewPreview: PreviewProvider {
  static var previews: some View {
    Preview {
      ProfileView(
        store: .init(
          initialState: ProfileReducer.State(),
          reducer: ProfileReducer()
        )
      )
    }
  }
}
