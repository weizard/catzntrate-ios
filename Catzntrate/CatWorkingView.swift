//
//  CatWorkingView.swift
//  Catzntrate
//
//  Created by Hsu,Che-Wei on 2022/2/16.
//

import SwiftUI
import ACarousel
import web3
import BigInt

enum PetWorkingState {
    case idle    // idle
    case working // state for concentrate
    case resting // state for rest
    case waiting // pause
}

struct CatWorkingView: View {
    // ==========================
    // ===    Environment     ===
    // ==========================
    
    @Environment(\.scenePhase) var scenePhase
    
    // ========= config =========
    // =  default time setting  =
    // ==========================
    
    let _defaultWorkingTime = 15
    let _defaultRestingTime = 10
    
    // ==========================
    // ===      Binding       ===
    // ==========================
    
    @Binding var pets:[Pet]
    @Binding var currentPetIndex:Int
    @Binding var userAccount: EthereumAccount
    @Binding var userBalances:[BigUInt]
    
    // ==========================
    // ===       State        ===
    // ==========================
    
    // coming soon
    @State public var showComingSoonPopup = false
    
    
    @State private var userScreenBrightness = UIScreen.main.brightness
    @State private var showWalletPopup = false
    
    // working
    @State private var timeRemaining = 0 // will be setup with defaul when start
    @State private var workingState: PetWorkingState = PetWorkingState.idle
    @State private var prevWorkingState = PetWorkingState.idle
    @State private var tmpWorkingState = PetWorkingState.idle
    @State private var hasPetted = false
    
    // timer trigger
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // ==========================
    // ==    Button Action     ==
    // ==========================
    
    func startAction() -> Void {
        userScreenBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = 0
        self.prevWorkingState = self.workingState
        self.workingState = PetWorkingState.working
        self.timeRemaining = _defaultWorkingTime
    }
    
    func finishAction() -> Void{
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
                CatzntrateHeaderBar(showComingSoonPopup: $showComingSoonPopup, showWalletPopup: $showWalletPopup, userBalances: $userBalances)

                // timer
                TimerView(timeRemaining: $timeRemaining).onReceive(timer) { _ in
                    if timeRemaining > 0 && self.workingState != PetWorkingState.waiting {
                        // working or resting
                        timeRemaining -= 1
                        // if working it will get exp
                        let levelUpbound = pets[currentPetIndex].status[0]*10+100
                        if self.workingState == PetWorkingState.working && pets[currentPetIndex].status[1] < levelUpbound {
                            pets[currentPetIndex].status[1] += 10
                            if pets[currentPetIndex].status[1] > levelUpbound {
                                pets[currentPetIndex].status[1] = levelUpbound
                            }
                        }
                    }else if self.hasPetted && self.workingState == PetWorkingState.resting{
                        timeRemaining = _defaultWorkingTime
                        self.workingState = PetWorkingState.working
                        self.hasPetted = false
                    }
                    else if self.workingState == PetWorkingState.working{
                        UIScreen.main.brightness = userScreenBrightness
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
                    Image("level").resizable().scaledToFit().frame(width:50)
                    Text(" :"+String(pets[currentPetIndex].status[0]+1)).fontWeight(.bold).padding(3).font(.system(size: 18)).padding([.trailing],15)
                    Image("hp").resizable().scaledToFit().frame(width:30)
                    Text(formateStatus(current:pets[currentPetIndex].status[3], upbound: 50, statusTitle: " ")).fontWeight(.bold).font(.system(size: 18)).padding([.trailing],15)
                    Image("sp").resizable().scaledToFit().frame(width:30)
                    Text(formateStatus(current:pets[currentPetIndex].status[4], upbound: 100, statusTitle: " ")).fontWeight(.bold).font(.system(size: 18)).padding([.trailing],15)
                    
                }.padding([.top, .bottom], 15)
                
                // button
                switch workingState {
                case .idle:
                    CatzntrateButton(action: startAction, text: "Start", systemName:"book")
                case .waiting:
                    HStack{
                        CatzntrateButton(action: countinueAction, text: "Continue", systemName:"play.circle")
                        CatzntrateButton(action: finishAction, text: "Finish", systemName:"stop.circle")
                    }
                default:
                    VStack{
                        if !self.hasPetted && self.workingState == PetWorkingState.resting {
                            CatzntrateButton(action: petAction, text: "Pet", systemName:"hand.raised")
                        }
                        HStack{
                            CatzntrateButton(action: waitingAction, text: "Pause", systemName:"pause.rectangle")
                            CatzntrateButton(action: finishAction, text: "Finish", systemName:"stop.circle")
                        }
                    }
                }
                
                // just for filled
                Spacer()
            }.popup(isPresented:$showComingSoonPopup, closeOnTapOutside: true ){ComingSoonView()}
            .popup(isPresented:$showWalletPopup, closeOnTap:false, closeOnTapOutside: true){WalletPopupView(userAccount: $userAccount)}
            .onDisappear{
                if (workingState==PetWorkingState.working || workingState==PetWorkingState.resting){
                    prevWorkingState = workingState;
                    workingState = PetWorkingState.waiting;
                }
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
        let keyStorage = EthereumKeyLocalStorage()
        CatWorkingView(pets: .constant([]), currentPetIndex: .constant(0), userAccount: .constant(try! EthereumAccount(keyStorage: keyStorage)), userBalances: .constant([]))
    }
}
