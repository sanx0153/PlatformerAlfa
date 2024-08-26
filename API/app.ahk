class App {
    __New(whichGame) {
        this.hub := APIHub(whichGame)
    }
    Start() {
        CallMainLoop := ObjBindMethod(this,"MainLoop")
        SetTimer(CallMainLoop,Integer(16))
    }
    MainLoop() {
        API.graphics.Update()
        API.game.Update()
        API.input.Update()
    }
}

class APIHub {
    __New(whichGame) {
        ;avoids duplication
        if IsSet(API) {
            MsgBox("Ja existe API")
        }else this.SetRef()
        ;creates API's
        this.input := InputAPI()
        this.graphics := GraphAPI()
        this.game := %whichGame%()
    }
    SetRef() {
        global API := this
    }
}

class Game {
        currentScene := ""
        nextSceneTitle := ""
    __New(firstSceneTitle := "Play") {
        this.SetNextScene(firstSceneTitle)
        this.shouldStartScene := true
        this.shouldEndScene := false
    }
    StartScene() {
        this.shouldStartScene := false
        this.currentScene := %this.nextSceneTitle%Scene()
        this.SetNextScene(this.currentScene.GetNextScene())
        this.currentScene.StartThisScene()
    }
    EndScene() {
        this.shouldEndScene := false
        API.graphics.DestroyWindow()
        API.graphics.CreateWindow()
    }
    Render() {
        this.currentScene.Render()
    }
    SetNextScene(name) {
        this.nextSceneTitle := name
    }
    Update() {
        if this.shouldEndScene = true
        {
            this.EndScene()
        }
        this.currentScene.Update()
        if this.shouldStartScene = true
        {
            this.StartScene()
        }
    }
}