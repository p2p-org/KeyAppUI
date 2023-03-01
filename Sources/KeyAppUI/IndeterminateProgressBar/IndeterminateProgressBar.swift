import SwiftUI

struct IndeterminateProgressBar: View {
    @State private var offset: CGFloat = 0

    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.1)
                    .foregroundColor(Color(Asset.Colors.night.color))

                Rectangle().frame(width: geometry.size.width / 2.5, height: geometry.size.height)
                    .foregroundColor(Color(Asset.Colors.night.color))
                    .cornerRadius(geometry.size.width / 2)
                    .offset(CGSize(width: offset, height: 0))
            }
            .cornerRadius(geometry.size.width / 2)
            .onReceive(timer) { _ in
                let progressWidth = geometry.size.width / 2.5
                withAnimation(.easeIn) {
                    offset += 15
                }
                if offset >= geometry.size.width + progressWidth {
                    offset = -progressWidth
                }
            }
        }
        .frame(height: 4)
    }
}

struct IndeterminateProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        IndeterminateProgressBar()
    }
}
