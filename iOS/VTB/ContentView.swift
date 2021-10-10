import SwiftUI
import VK_ios_sdk
import TGPassportKit

struct ContentView: View {
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            if self.isActive {
                LoginScreen()
            } else {
                ZStack{
                    Rectangle()
                        .fill(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor))
                        .background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct LoginScreen: View {
    @State private var Email = ""
    @State private var Password = ""
    let tg_bot_config = TGPBotConfig(botId: 2078515739, publicKey: "XXX")
    @State private var result = VKAuthorizationResult()
    
    
    var body: some View {
        NavigationView{
            VStack{
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                TextField("E-mail", text: $Email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                
                SecureField("Пароль", text: $Password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                
                NavigationLink(destination: RegistrationView()){
                    Text("Войти")
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 380)
                .background(Color(UIColor(red: 0.137, green: 0.255, blue: 0.443, alpha: 1).cgColor))
                .padding(.bottom,40)
                .padding(.top,40)
                Button(action: {
                    VKSdk.authorize(["online"])
                }, label: {
                    HStack {
                        Image("VK")
                        Text("Войти через Вконтакте")
                    }
                })
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 380)
                    .background(Color(UIColor(red: 0.027, green: 0.349, blue: 0.522, alpha: 1).cgColor))
                    .padding()
                Button(action: {
                    let req = TGPRequest(botConfig: tg_bot_config)
                    req.perform(with: TGPScope(jsonString: "{\"data\": [\"email\"]}"), nonce: "XXX", completionHandler: {(res, err) -> Void in
                        switch (res) {
                            case TGPRequestResult.succeed:
                                //RegistrationViev()
                                break;
                            case TGPRequestResult.cancelled:
                                // LoginScreen()
                                break;
                            default:
                                // LoginScreen()
                                break;
                        }
                        //let registrationView = RegistrationView()
                        //self.navigationController?.pushViewController(registrationView, animated: true)
                    })
                }, label: {
                    HStack{
                        Image("Telegram")
                        Text("Войти через Telegram")
                    }
                })
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 380)
                    .background(Color(UIColor(red: 0.024, green: 0.714, blue: 0.831, alpha: 1).cgColor))
                Spacer()
                Spacer()
            }.background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        }
    }
}

struct RegistrationView: View {
    @State private var education = ["нет","среднее","высшее"]
    @State private var SelectedEducation=0
    @State private var dohod: Double = 0
    @State private var age: Double = 0
    var body: some View {
        VStack{
            VStack {
                ZStack {
                    Text("Давайте познакомимся!")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 390, height: 115, alignment: .leading)
                        .offset(x: 15, y: -20)
                    
                    Text("Ф")
                        .fontWeight(.light)
                        .font(.system(size: 160))
                        .foregroundColor(.white)
                        .tracking(34.20)
                        .multilineTextAlignment(.center)
                        .frame(width: 155, height: 155)
                        .opacity(0.70)
                        .offset(x: 174.50, y: -30)
                }
                .frame(width: 391, height: 56)
                .background(Color(red: 0.09, green: 0.125, blue: 0.188))
                .border(Color(red: 0.09, green: 0.13, blue: 0.19, opacity: 0.40), width: 0.50)
                .shadow(radius: 4, y: 4)
                Text("Здравствуйте, в этом приложении мы разрушим все ваши страхи и стереотипы об инвестициях! Нам необходимо узнать немного информации о вас, чтобы предложить наши лучшие решения!")
                    .foregroundColor(.white)
                    .padding()
                    .shadow(radius: 4, y: 4)
                Text("Выбирите свой уровень образования")
                    .foregroundColor(.white)
                    .padding()
                    .font(.title3)
                Picker (selection: $SelectedEducation, label: Text("Ваш пол")){
                    ForEach(0..<education.count){                        Text(self.education[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                    .background(Color(red: 0.11, green: 0.17, blue: 0.27))
                Text("Выбирите свой уровень дохода:")
                    .foregroundColor(.white)
                    .padding()
                    .font(.title3)
                Text("Приблизительно: \(dohod, specifier: "%.2f")")
                    .foregroundColor(.white)
                Slider(value: $dohod, in: 15000...500000, step: 5000)
                    .padding(.leading)
                    .padding(.trailing)
                Text("Выберите свою возрастную категорию:")
                    .foregroundColor(.white)
                    .padding()
                Text("Приблизительно: \(age, specifier: "%.2f")")
                    .foregroundColor(.white)
                Slider(value: $age, in: 15000...500000, step: 5000)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            
            NavigationLink(destination: EnotherView()){
                Text("Далее")
                
            }
            Spacer()
        }.background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
        
    }
}

struct EnotherView: View {
    @State private var Page=1
    @State private var nameField = "Иван"
    var body: some View {
        TabView(selection: $Page){
            VStack{
                Image("Header Games")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 380, height: 120)
                Image("MiniGame 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 380, height: 200)
                Image("MiniGame 2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 380, height: 200)
                    .padding(.bottom,80)
                Spacer()
            }.background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
                .tabItem {
                    Image("Games")
                        .foregroundColor(self.Page == 1 ? .black : .blue)
                }
            
            
            
            
            
            VStack{
                Image("Header BackPack")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 380, height: 120)
                Spacer()
                HStack{
                    Image("Stock 1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                    Text("StockName 1")
                        .foregroundColor(.white)
                        .padding()
                    Text("100,57₽")
                        .foregroundColor(.green)
                        .padding(40)
                }.frame(width: 380, height: 80)
                    .border(LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0)]), startPoint: .leading, endPoint: .trailing), width: 3)
                HStack{
                    Image("Stock 2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                    Text("StockName 2")
                        .foregroundColor(.white)
                        .padding()
                    Text("42.96₽")
                        .foregroundColor(.red)
                        .padding(40)
                }.frame(width: 380, height: 80)
                    .border(LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0)]), startPoint: .leading, endPoint: .trailing), width: 3)
                HStack{
                    Image("Stock 3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                    Text("StockName 3")
                        .foregroundColor(.white)
                        .padding()
                    Text("54,78₽")
                        .foregroundColor(.green)
                        .padding(40)
                }.frame(width: 380, height: 80)
                    .border(LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0)]), startPoint: .leading, endPoint: .trailing), width: 3)
                    .padding(.bottom,20)
            }.background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
                .tabItem {
                    Image("BackPack")
                }
            
            
            
            
            
            
            VStack{
                Image("Header Accaount")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 380, height: 100)
                Image("Avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                TextField("", text: $nameField)
                    .foregroundColor(.white)
                    .background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.308, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
                    .padding(.trailing,130)
                    .padding(.leading,130)
                Text("Общая статистика")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom,150)
                Button(action: {
                }, label: {
                    HStack {
                        Text("Приложение \"ВТБ мои Инвестиции\"")
                    }
                    .padding()
                }).frame(width: 300)
                    .foregroundColor(.white)
                    .frame(width: 380)
                    .background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.288, alpha: 1).cgColor))
                Button(action: {
                }, label: {
                    HStack {
                        Text("Школа инвесторов ВТБ")
                    }
                    .padding()
                }).frame(width: 300)
                    .foregroundColor(.white)
                    .frame(width: 380)
                    .background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.288, alpha: 1).cgColor))
                Button(action: {
                }, label: {
                    HStack {
                        Text("Школа инвесторов ВТБ")
                    }.padding(.top)
                }).frame(width: 300)
                    .foregroundColor(.white)
                    .frame(width: 380)
                    .background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.288, alpha: 1).cgColor))
                    .padding(.bottom,100)
                Spacer()
            }.background(Color(UIColor(red: 0.09, green: 0.125, blue: 0.188, alpha: 1).cgColor).edgesIgnoringSafeArea(.all))
                .tabItem {
                    Image("Accaount")
                }
        
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 8")
        }
    }
}
