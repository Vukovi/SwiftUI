# SwiftUI

## 01 Async Image - umesto Kingfisher ili umesto SDWebIamge

### jednostavan projekat koji pokazuje kako uraditi ekstenziju i manipulisati sa slikom, pozicijom, odzivom itd
![asyncImage](Screenshots/AsyncImage.jpg)

## 02 Restart App - izolovani view, organizacija view-eva, animacije, gesture-i,

### pozicioniranje view-eva, ZStack, VStack, HStack
### @AppStorage - pojednostavljen UserDefaults
### @State var someProperty - slicno mutating keyword-u jer su view-evi strukture
![restartApp](https://github.com/Vukovi/SwiftUI/blob/main/Screenshots/View%2C%20Animation%2C%20Gesture.jpg)

## 03 Pinch App - SwiftUI gestures, SiftUI Materials, SF Symbols

### pinch gesture
### zoom gesture
### long tap gesture
### drawer user interface
### .navigationViewStyle(.stack) -> onemugucava side bar na iPadu
### neka View komponenta je zavrsena, npr HStack, a nisam planirao da radim sa ZStack-om
###    da bih ostvario preklapanje sa jos nekim View-em, zato na kraju "donjeg" View-a dodam .overlay()
###    npr HStack {...}.overlay(..razne druge View komponente..)
![pinchApp](https://github.com/Vukovi/SwiftUI/blob/main/Screenshots/Screenshot%202023-05-22%20at%2014.00.24.png)
