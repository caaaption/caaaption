import SwiftUI

struct OnboardWrap<Content, Footer>: View where Content: View, Footer: View {
  var title: LocalizedStringKey
  var description: LocalizedStringKey? = nil
  @ViewBuilder var content: () -> Content
  @ViewBuilder var footer: () -> Footer
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer().frame(height: 71)
      
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.title)
          .bold()
        
        if let description = self.description {
          Text(description)
            .font(.headline)
            .foregroundColor(.systemGray2)
        }
      }
      
      Spacer().frame(height: 50)
      
      content()
      
      Spacer()
      
      footer()
      
      Spacer().frame(height: 24)
    }
    .padding(.horizontal, 24)
    .navigationBarBackButtonHidden()
  }
}
