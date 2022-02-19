//
//  CatWorkingView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import SwiftUI
import ACarousel

enum PetWorkingState {
    case idle    // idle
    case working // state for concentrate
    case resting // state for rest
    case waiting // pause
}

struct CatzntrateButton:View{
    let action: () -> Void
    let text:String
    
    var body: some View {
        Button(action:action){
            Text(text).foregroundColor(Color.white).padding(10).font(.system(size: 20))
        }.background(Color.blue).cornerRadius(5)
    }
}

struct CatWorkingView: View {
    
    // ========= config =========
    // =  default time setting  =
    // ==========================
    
    let _defaultWorkingTime = 30
    let _defaultRestingTime = 3
    
    // ==========================
    // ===      Binding       ===
    // ==========================
    
    @Binding var pets:[Pet]
    @Binding var currentPetIndex:Int
    
    // ==========================
    // ===       State        ===
    // ==========================
    
    // coming soon
    @State public var showComingSoonPopup = false
    
    // working
    @State private var timeRemaining = 0 // will be setup with defaul when start
    @State private var workingState: PetWorkingState = PetWorkingState.idle
    @State private var prevWorkingState = PetWorkingState.idle
    @State private var tmpWorkingState = PetWorkingState.idle
    @State private var hasPetted = false
    @Environment(\.scenePhase) var scenePhase
  
    // timer trigger
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // ==========================
    // ==    Button Action     ==
    // ==========================
    
    func startAction() -> Void {
        self.prevWorkingState = self.workingState
        self.workingState = PetWorkingState.working
        self.timeRemaining = _defaultWorkingTime
    }
    
    func stopAction() -> Void{
        self.prevWorkingState = self.workingState
        self.workingState = PetWorkingState.idle
    }
    
    func waitingAction() -> Void{
        self.prevWorkingState = self.workingState
        self.workingState = PetWorkingState.waiting
    }
    
    func countinueAction() -> Void{
        self.workingState = self.prevWorkingState
        self.prevWorkingState = PetWorkingState.waiting
    }
    
    func petAction() -> Void{
        self.prevWorkingState = self.workingState
        self.hasPetted = true
    }
    
    
    var body: some View {
        
        ZStack{
            Image("forest_bg").resizable().opacity(0.2)
            VStack( spacing: 20 ){
                CatzntrateHeaderBar(showComingSoonPopup: $showComingSoonPopup)
                
                // timer
                TimerView(timeRemaining: $timeRemaining).onReceive(timer) { _ in
                    if timeRemaining > 0 && self.workingState != PetWorkingState.waiting {
                        // working or resting
                        timeRemaining -= 1
                        // if working it will get exp
                        if self.workingState == PetWorkingState.working && pets[currentPetIndex].status[1] < 100{
                            pets[currentPetIndex].status[1] += 10
                            if pets[currentPetIndex].status[1] > 100 {
                                pets[currentPetIndex].status[1] = 100
                            }
                        }
                    }else if self.hasPetted && self.workingState == PetWorkingState.resting{
                        timeRemaining = _defaultWorkingTime
                        self.workingState = PetWorkingState.working
                        self.hasPetted = false
                    }
                    else if self.workingState == PetWorkingState.working{
                        self.workingState = PetWorkingState.resting
                        timeRemaining = _defaultRestingTime
                    }
                }.hidden(self.workingState == PetWorkingState.idle)
                
                // pet
                switch workingState {
                case PetWorkingState.idle:
                    ACarousel(pets.indices,id:\.self, index: $currentPetIndex){
                        index in
                        Image(pets[index].imageUrl).resizable().scaledToFit().frame(height: 300)
                    }.frame(height: 300)
                case PetWorkingState.working:
                    Image("bufficorn_coding").resizable().scaledToFit().frame(height: 300)
                case PetWorkingState.resting:
                    Image("bufficorn").resizable().scaledToFit().frame(height: 300)
                default:
                    Image("bufficorn_sleeping").resizable().scaledToFit().frame(height: 300)
                }
                
                // status
                HStack(spacing:0){
                    Text("LV: "+String(pets[currentPetIndex].status[0])).padding(3).font(.system(size: 18))
                    Text("HP: "+String(pets[currentPetIndex].status[3])+"/100").padding(3).font(.system(size: 18))
                    Text("SP: "+String(pets[currentPetIndex].status[4])+"/100").padding(3).font(.system(size: 18))
                }.padding([.top, .bottom], 15).border(Color.black, width: 2)
                
                // button
                switch workingState {
                case .idle:
                    CatzntrateButton(action: startAction, text: "Start")
                case .waiting:
                    HStack{
                        CatzntrateButton(action: countinueAction, text: "Continue")
                        CatzntrateButton(action: stopAction, text: "Stop")
                    }
                default:
                    HStack{
                        if !self.hasPetted && self.workingState == PetWorkingState.resting {
                            CatzntrateButton(action: petAction, text: "Pet")
                        }
                        CatzntrateButton(action: waitingAction, text: "Pause")
                        CatzntrateButton(action: stopAction, text: "Stop")
                    }
                }
                
                // just for filled
                Spacer()
            }.popup(isPresented:$showComingSoonPopup, closeOnTapOutside: true ){ComingSoonView()}.onAppear {
//                tmpWorkingState = prevWorkingState;
//                prevWorkingState = workingState;
//                workingState = tmpWorkingState;
//                print("ContentView appeared!")
            }.onDisappear{
                if (workingState==PetWorkingState.working || workingState==PetWorkingState.resting){
                    prevWorkingState = workingState;
                    workingState = PetWorkingState.waiting;
                }
                
//                prevWorkingState = workingState;
//                workingState = PetWorkingState.waiting;
//                print("DetailView disappeared!")
            }.onChange(of: scenePhase) { (phase) in
                switch phase {
                case .active:
                    print("ScenePhase: Active")
                case .background:
                    if (workingState==PetWorkingState.working || workingState==PetWorkingState.resting){
                        prevWorkingState = workingState;
                        workingState = PetWorkingState.waiting;
                    }
                case .inactive:
                    print("ScenePhase: inactive entering background" )
                }
            }
        }
    }
}

struct CatWorkingView_Previews: PreviewProvider {
    static var previews: some View {
        CatWorkingView(pets: .constant([]), currentPetIndex: .constant(0))
    }
}
