class block extends AbstractObject
{
    __New(skinset,subset,x,y,frame := 1)
    {
        super.__New(skinset,subset,x,y,frame)
        this.canFall := false
        this.isFixed := true
    }
}

class box extends AbstractObject
{
    __New(x,y)
    {
        super.__New("tiles","box",x,y,2)
    }
}


class textblock extends AbstractObject
{
    __New(color,text := "",x := 0,y := 0,spriteNumber := 1)
    {
        this.text := text
        super.__New("blocks",color,x,y,spriteNumber,"Text")
        this.canFall := false
        this.isFixed := true
    }

    GetColor() 
    {
        return this.avatar.GetColor()
    }
    SetColor(color,frame := 1)
    {
        this.subSet := color
        this.frame := frame
        this.avatar.SetColor(color,frame)
    }
    SetText(text)
    {
        this.text := text
        this.avatar.SetText(text)
    }
}