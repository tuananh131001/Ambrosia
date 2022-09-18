/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Vo Quoc Huy
 ID: s3879954
 Created  date: 10/09/2022
 Last modified: 10/09/2022
 Acknowledgement:
 https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component
 */

import SwiftUI



struct RatingView: View {
    // Binding to update variable from other views
    @Binding var rating: Int
    @State var tappable:Bool
    var width:CGFloat
    var height:CGFloat
    var label = ""
    
    // Assign value for maximum rating
    var maximumRating = 5
    
    // Assign image before and after rating
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    // Assign the color for image before and after rating
    var onColor = UIColor(Color("Star On Color"))
    var offColor = UIColor(Color("Star Off Color"))
    
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .resizable()
                    .frame(width: width, height: height)
                    .foregroundColor(Color(number > rating ? offColor : onColor))
                    .onTapGesture {
                        // if can change razting
                        if (tappable){
                            rating = number

                        }
                    }
                    
            }
        }
    }
    
    // Update the image base on the rating number 
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
}

struct RatingViewPreview:PreviewProvider{
    static var previews: some View {
        RatingView(rating: .constant(4),tappable:true,width: 14,height: 14)
    }

}
