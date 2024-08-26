class MovingAvatar extends AbstractAvatar {
    __New(parent,spriteSet,subSet) {
        super.__New(parent,spriteSet,subSet)
        this.UpdateLastFrame()
    }
    Animate() 
    {
        if Integer(this.currentFrame) > this.lastFrame
        {
            this.currentFrame := 1
        }
        this.control.Value := API.graphics.Sprite(this.spriteSet,this.subSet,Integer(this.currentFrame))
        this.currentFrame += Round(1/2,4)
    }
    ChangeSubSet(subSetName)
    {
        this.subSet := subSetName
        this.UpdateLastFrame()
    }
    Render() {
        super.Render()
        this.Animate()
    }
    Update()
    {
        super.Update()
        this.UpdateLastFrame()
    }
    UpdateLastFrame()
    {
        this.lastFrame := API.graphics.TargetFrameNumber(this.spriteSet,this.subSet)
    }
}
class StaticAvatar extends AbstractAvatar {
    __New(parent,spriteSet,subSet,frame := 1) {
        super.__New(parent,spriteSet,subSet,frame)
    }
}
class TextAvatar extends AbstractAvatar {
    __New(parent,skinset,subSet,spriteNumber := 1) {
        super.__New(parent,"blocks",subSet,spriteNumber)
        this.text := API.graphics.Text()
    }
    Hide() {
        super.Hide()
        ControlHide(this.text)
    }
    GetColor() {
        return this.subSet
    }
    Move(x,y) {
        super.Move(x,y)
        this.text.Move(x,y)
    }
    SetColor(color,frame := 1) {
        this.subSet := color
        this.control.Value := API.graphics.Sprite("blocks",color,frame)
    }
    SetText(text) {
        this.text.Value := StrUpper(text)
    }
    Show() {
        super.Show()
        ControlShow(this.text)
    }
    Update()
    {
        super.Update()
        this.SetText(this.parent.text)
    }
}