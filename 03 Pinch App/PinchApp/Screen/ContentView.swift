//
//  ContentView.swift
//  PinchApp
//
//  Created by Vuk Knezevic on 18.05.23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Property
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    // MARK: Function
    func resetImageState() {
        withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentImage() -> String {
        return pages[pageIndex - 1].imageName
    }
    // MARK: Content
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear // ovim je info panel podignut od leve gornje tacke postera
                
                // MARK: Page Image
                Image(currentImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(
                        color: .black.opacity(0.2),
                        radius: 12,
                        x: 2,
                        y: 2
                    )
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width,
                            y: imageOffset.height)
                    .scaleEffect(imageScale)
                    // MARK: 1. Tap Gesture
                    .onTapGesture(count: 2) {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetImageState()
                        }
                    }
                    // MARK: 2. Drag Gesture
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
                // MARK: 3. Magnification Gesture
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)) {
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    } else if imageScale > 5 {
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                } else if imageScale <= 1 {
                                    resetImageState()
                                }
                            })
                    )
            } //: ZStack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            }
            // MARK: 3. Info Panel
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                
                ,alignment: .top
            )
            // MARK: 4. Controls
            .overlay(
                HStack {
                    // SCALE DOWN
                    Button {
                        withAnimation(.spring()) {
                            if imageScale > 1 {
                                imageScale -= 1
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        }
                    } label: {
                        ControlImageView(iconName: "minus.magnifyingglass")
                    }
                    
                    // RESET
                    Button {
                        resetImageState()
                    } label: {
                        ControlImageView(iconName: "arrow.up.left.and.down.right.magnifyingglass")
                    }
                    
                    // SCALE UP
                    Button {
                        withAnimation(.spring()) {
                            if imageScale < 5 {
                                imageScale += 1
                                
                                if imageScale > 5 {
                                    imageScale = 5
                                }
                            }
                        }
                    } label: {
                        ControlImageView(iconName: "plus.magnifyingglass")
                    }
                    
                } //: CONTROLS
                .padding(
                    EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
                )
                .background(.ultraThinMaterial)
                .padding(.bottom, 30)
                .opacity(isAnimating ? 1 : 0)
                
                ,alignment: .bottom
            )
            // MARK: 5. Drawer - side menu
            .overlay(
                HStack(spacing: 12) {
                    // MARK: Drawer handle
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    // MARK: Drawer thumbnails
                    ForEach(pages) { page in
                        Image(page.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                            .onTapGesture {
                                isAnimating = true
                                pageIndex = page.id
                            }
                    }
                    
                    Spacer()
                } //: Drawer
                    .padding(
                        EdgeInsets(
                            top: 16,
                            leading: 8,
                            bottom: 16,
                            trailing: 8
                        )
                    )
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing
            )
        } //: NAVIGATION VIEW
        .navigationViewStyle(.stack) // onemugucava side bar na iPadu
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
