class TitleScene extends AbstractScene {
    TopText := []
    BottomText := []
    __New() {
        super.__New("title","play")
    }
    CheckAction() {
        state := this.player.GetState("space")
        if state = 1 
        {
            this.PlayerChooses()
        }
    }
    CheckChoice() {
        if Type(this.bottomText) != "Array"
        {
            return
        }
        state := this.player.GetState(["left","right"])
        switch state 
        {
            case 10:
                this.bottomText[1].SetText("D")
                this.bottomText[2].SetText("O")
                this.bottomText[3].SetText("G")
                this.choice := "dog"
            case 01:
                this.bottomText[1].SetText("C")
                this.bottomText[2].SetText("A")
                this.bottomText[3].SetText("T")
                this.choice := "cat"
            default:
                return      
        }
    }
    PlayerChooses() {
        if !(this.choice) {
            return MsgBox("Please Pick One")
        }
        MsgBox("You will play as a " this.choice,,"T1")
        API.game.SetPlayerSkin(this.choice)
        this.endThisScene := true
    }
    Render() {
        super.Render()
        loop this.toptext.Length
        {
            this.toptext[A_Index].Render()
        }
        loop this.bottomtext.Length
        {
            this.bottomtext[A_Index].Render()
        }
    }
    StartThisScene() {
        super.StartThisScene()
        this.CreateText("top","red","pick",Integer(WINDOWS_SIZE * 0.3))
        this.CreateText("bottom","orange","???",Integer(WINDOWS_SIZE * 0.82))
        this.choice := ""
    }
    UpdateLogic() {
        loop this.toptext.Length
        {
            this.toptext[A_Index].Update()
        }
        loop this.bottomtext.Length
        {
            this.bottomtext[A_Index].Update()
        }
        this.CheckChoice()
        this.CheckAction()
    }
}

class TitlePlayer extends AbstractPlayer 
{

}

class PlayScene extends AbstractScene 
{
    __New() 
    {
        super.__New("play","title")
        this.playerSkin := API.game.playerSkin
    }
    CreatePlayerAvatar() 
    {
        this.playerAvatar := %this.playerSkin%(60,540)
    }
    LoadTerrain() 
    {
        this.blocks := []
        loop 5 
        {
            this.blocks.Push(block("tiles","boxExplosive",(Random(0,10) * TILE_SIZE),(Random(5,8) * TILE_SIZE)))
        }
        this.blocks.Push(box((TILE_SIZE * 5),(TILE_SIZE * 5)))
    }
    Render() 
    {
        super.Render()
        this.RenderBlocks()
        ;this.RenderCreatures()
        this.playerAvatar.Render()
    }
    RenderBlocks() 
    {
        loop this.blocks.Length
        {
            this.blocks[A_Index].Render()
        }
    }
    SummonCreatures() 
    {
        
    }
    StartThisScene()
    {
        super.StartThisScene()
        this.LoadTerrain()
        this.SummonCreatures()
        this.CreatePlayerAvatar()
    }
    UpdateLogic()
    {
        this.playerAvatar.Update()
        xMovement := this.player.GetState(["left","right"])
        switch xMovement 
        {
            case 10:
                this.playerAvatar.Walk(true)
            case 01:
                this.playerAvatar.Walk(false)
            default:
                this.playerAvatar.Still()
        }
        if this.player.GetState("space") 
        {
            this.playerAvatar.Jump()
        }
        if this.playerAvatar.isJumping = true && this.player.GetState("space") = false 
        {
            this.playerAvatar.StopJumping()
        }
        loop this.blocks.Length 
        {
            this.blocks[A_Index].Update()
        } 
    }
}
class PlayPlayer extends AbstractPlayer 
{
    
}