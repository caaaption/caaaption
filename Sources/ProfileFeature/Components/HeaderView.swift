//ZStack(alignment: .topTrailing) {
//  VStack(alignment: .leading) {
//    Color.blue
//      .frame(height: 120)
//
//    VStack(alignment: .leading) {
//      Text("tomokisun")
//        .font(.largeTitle)
//        .bold()
//
//      Spacer().frame(height: 4)
//
//      Text("@tomokisun")
//        .font(.caption)
//        .bold()
//        .padding(.vertical, 8)
//        .padding(.horizontal, 12)
//        .background(Color(uiColor: .systemGray6))
//        .cornerRadius(6)
//
//      Spacer().frame(height: 8)
//
//      Text("Active 19m ago")
//        .font(.caption2)
//        .fontWeight(.medium)
//    }
//    .padding(.horizontal, 32)
//  }
//
//  Color.red
//    .frame(width: 120, height: 120)
//    .cornerRadius(22)
//    .padding(.top, 80)
//    .padding(.trailing, 32)
//}

import ComposableArchitecture
import SwiftUI

public struct HeaderView: View {
  let store: StoreOf<HeaderReducer>

  public init(store: StoreOf<HeaderReducer>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { _ in
      ZStack(alignment: .top) {
        Color.blue
          .frame(height: 120)
        
        VStack {
          HStack(alignment: .bottom) {
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
            
            Spacer()
            
            Color.red
              .frame(width: 120, height: 120)
              .cornerRadius(22)
              .padding(.bottom, 32)
          }
          .padding(.top, 80)
          .padding(.bottom, 16)
          .padding(.horizontal, 32)
          
          Text("21 yrs. / founder of caaaption.com / party  organizer at FWB / love: DJ-ing")
            .font(.headline)
        }
      }
    }
  }
}

struct HeaderViewPreviews: PreviewProvider {
  static var previews: some View {
    HeaderView(
      store: .init(
        initialState: HeaderReducer.State(),
        reducer: HeaderReducer()
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
