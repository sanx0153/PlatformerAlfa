class AbstractAvatar {
    __New(parent,spriteSet,subSet,frame := 1) {
        this.control := API.graphics.control()
        this.control.Move(,,TILE_SIZE,TILE_SIZE)
        this.control.Value := API.graphics.Sprite(spriteSet,subSet,frame)
        this.parent := parent
        this.x := this.parent.x
        this.y := this.parent.y
        this.currentFrame := frame
        this.spriteSet := spriteSet
        this.subSet := subSet
    }
    Hide() 
    {
        ControlHide(this.control)
    }
    Render() 
    {
        this.Move(this.x,this.y)
    }
    Show() 
    {
        ControlShow(this.control)
    }
    Move(x,y) 
    {
        this.control.Move(x,y)
    }
    Update() 
    {
        this.x := this.parent.x
        this.y := this.parent.y
    }
}

class AbstractBody
{
    __New(x,y)
    {
        this.x := x
        this.y := y
        this.canFall := true
        this.canJump := false
        this.fallCount := 0
        this.isFalling := false
        this.isFixed := false
        this.isSupported := false
        this.isJumping := false
        this.hitbox := HitBox(this)
    }
    Drag(x := 0, y := 0)
    {
        this.x += x
        this.y += y
    }
    SetX(value) 
    {
        this.x := value
    }
    SetY(value) 
    {
        this.y := value
    }
    StayInScreen() 
    {
        if ((this.y + TILE_SIZE) >= WINDOWS_SIZE) 
        {
            this.TouchesFloor()
            this.SetY((WINDOWS_SIZE - TILE_SIZE))
        }
    }
    StopFalling()
    {
        this.isFalling := false
        this.fallCount := 0
    }
    SuffersGravity() 
    {
        this.isFalling := true
        if this.fallCount < 3
        {
            this.fallCount++
            return
        }
        this.y += ((3 * this.fallCount))
        if this.fallCount < 10
        {
            this.fallCount++
        }
    }
    TouchesFloor() 
    {
        this.StopFalling()
        this.isSupported := true
        this.canJump := true
    }
    Update() 
    {
        if this.isSupported = false && this.isJumping = false && this.canFall = true
        {
            this.SuffersGravity()
        }
        this.StayInScreen()
        this.hitbox.Update()
    }
}

class AbstractBeing extends AbstractBody
{
    __New(skinset,subset,x,y) 
    {
        super.__New(x,y)
        this.avatar := MovingAvatar(this,skinset,subset)
        this.goingLeft := false
        this.goingRight := false
        this.JumpCount := 0
        this.JumpCountLimit := 15
        this.walkCount := 0
        this.status := ""
    }
    DecideStatus()
    {
        data1 .= this.goingLeft
        data1 .= this.goingRight
        data1 .= this.isSupported
        data2 .= this.isFalling
        data2 .= this.isJumping
        switch data2
        {
            case 10:
                this.status := "falling"
            case 01:
                this.status := "jumping"
            default:
                switch data1
                {
                    case 101:
                        this.status := "walking"
                        case 011:
                            this.status := "walking"
                            case 001:
                                this.status := "idle"
                            }
        }

    }
    Move(x,y) 
    {
        this.x := x
        this.y := y
    }
    Jump() 
    {
        if this.canJump = true 
        {
            this.isJumping := true
            this.y -= Ceil(this.JumpCountLimit - (this.JumpCount))
            this.JumpCount += 0.5
            this.isSupported := false
            if Integer(this.JumpCount) > this.JumpCountLimit
            {
                ;this.JumpCount := 0
                this.StopJumping()
            }
        }
    }
    Render() 
    {
        this.Avatar.Render()
    }
    StopJumping() 
    {
        this.JumpCount := 0
        this.canJump := false
        this.isJumping := false
    }
    Still()
    {
        this.walkCount := Integer(this.walkCount / 2)
        if this.walkCount > 2
        {
            this.Walk(this.goingLeft)
            return
        } else 
        {
            this.goingLeft := false
            this.goingRight := false
            this.walkCount := 0
        }
    }
    Update() 
    {
        super.Update()
        this.DecideStatus()
        this.avatar.ChangeSubSet(this.status)
        this.avatar.Update()

    }
    Walk(toLeft := false) 
    {
        thisMuch := Integer(0.9 * this.walkCount)
        if toLeft = true 
        {
            thisMuch *= (-1)
            this.goingLeft := true
            this.goingRight := false
        } else
            {
                this.goingRight := true
                this.goingLeft := false
            }
        this.x += thisMuch
        if this.walkCount < 20
            {
                this.walkCount++
            } 
    }
}

class AbstractObject extends AbstractBody
{
    __New(skinset,subset,x,y,frame := 1,avatarType := "Static")
    {
        super.__New(x,y)
        this.skinset := skinset
        this.subSet := subset
        this.frame := frame
        this.avatarType := avatarType
        this.CreateAvatar()
    }
    CreateAvatar()
    {
        this.avatar := %this.avatarType%Avatar(this,this.skinset,this.subset,this.frame)
    }
    Move(x?,y?)
    {
        if x
            this.x := x
        if y
            this.y := y
    }
    Render()
    {
        this.avatar.Render()
    }
    Update()
    {
        super.Update()
        this.avatar.Update()
    }
}

class AbstractScene {
    title := ""
    background := ""
    bricks := []
    shouldStartScene := true
    shouldEndScene := false
    player := ""
    queue := Queue()
    collisionManager := CollisionManager()
    __New(title,nextSceneTitle) {
        this.title          := title
        this.nextSceneTitle := nextSceneTitle
        this.shouldEndScene := false
        this.collisionManager := CollisionManager()
        API.graphics.CreateWindow()

    }
    CreateBackgroundControl() {
        control := API.graphics.Control()
        control.Move(0,0,WINDOWS_SIZE,WINDOWS_SIZE)
        return control
    }
    CreateText(varName,color,text,y) {
        text               := StrSplit(text)
        color              := color
        xFirst             := Round((WINDOWS_SIZE / 2) - (TILE_SIZE * (text.Length / 2)))
        y                  := y
        this.%varName%Text := []
        loop text.Length {
            this.%varName%Text.Push(TextBlock(color,text[A_Index]))
            this.%varName%Text[A_Index].Move((xFirst + ((A_Index - 1) * TILE_SIZE)),y)   
        }
    }
    CreateTextLeft(varName,color,text,y) {
        text               := StrSplit(text)
        color              := color
        xFirst             := Round((10 + (WINDOWS_SIZE / 4) - (TILE_SIZE * (text.Length / 2))))
        y                  := y
        this.%varName%Text := []
        loop text.Length {
            this.%varName%Text.Push(TextBlock(color,text[A_Index]))
            this.%varName%Text[A_Index].Update((xFirst + ((A_Index - 1) * TILE_SIZE)),y)   
        }
    }
    CreateTextRight(varName,color,text,y) {
        text               := StrSplit(text)
        color              := color
        xFirst             := Round(((WINDOWS_SIZE / 4) * 3) - (TILE_SIZE * (text.Length / 2)))
        y                  := y
        this.%varName%Text := []
        loop text.Length {
            this.%varName%Text.Push(TextBlock(color,text[A_Index]))
            this.%varName%Text[A_Index].Update((xFirst + ((A_Index - 1) * TILE_SIZE)),y)   
        }
    }
    EndScene() {
        API.game.shouldEndScene := true
    }
    GetNextScene() {
        return this.nextSceneTitle
    }
    Render() {
        this.player.Render()
    }
    StartThisScene()
    {
        this.shouldStartScene := false
        this.background     := this.CreateBackgroundControl()
        this.player         := %this.title%Player()
        this.SetBackground()
    }
    SetBackground(SubSet := this.title,Frame := 1) {
        this.background.Value := API.graphics.Sprite("bg",SubSet,Frame)
    }
    UpdateInput()
    {
        this.player.Update()
    }
    UpdateLogic()
    {
        
    }
    UpdatePhysics()
    {
        this.collisionManager.Update()
    }
    Update() {
        if this.shouldEndScene = true {
            this.EndScene()
        }
        if this.shouldStartScene = true
        {
            this.StartThisScene()
        }
        this.UpdateInput()
        this.UpdateLogic()
        this.UpdatePhysics()
    }
}

class CollisionManager
{
    grid := Map()
    __New()
    {
        this.grid.Default := Array()
        this.grid.Capacity := (Integer(WINDOWS_SIZE / (TILE_SIZE)) ** 2)
        this.EmptyGrid()
    }
    ActuallyCheckCollision(one,another)
    {
        if one = another
        {
            return
        }
        collisionHappens := this.CompareVertexes(one,another)
        if collisionHappens = true
        {
            one.CollidesWith(another)
            another.CollidesWith(one)
        }
    }
    CheckCollision(cellNumber)
    {
        one := this.grid[cellNumber].Pop()
        while this.grid[cellNumber].Length > 0
        {
            loop this.grid[cellNumber].Length
            {
                another := this.grid[cellNumber][A_Index]
                if one != another
                {
                    this.ActuallyCheckCollision(one,another)
                }
            }
        }
        if cellNumber + 1 <= 10
        {
            this.grid[cellNumber + 1].Push(one)
        }
        if cellNumber + 10 <= this.grid.Capacity && this.grid[cellNumber + 10].Length > 0 
        {
            this.grid[cellNumber + 10].Push(one)
        }
    }
    CompareVertexes(one,another)
    {
        switch
        {
            case one.y2 >= another.y1 :
                one.parent.y := ((another.y1 - 1) - one.height)
                one.TouchesFloor()
            case one.y1 <= another.y2 :
                one.parent.y := (another.y2 + 1)
            case one.x1 <= another.x2 :
                one.parent.x := (another.x2 + 1)
            case one.x2 >= another.y1 :
                one.parent.x := ((another.x1 - 1) - this.width)
        }
    }
    EmptyGrid()
    {
        this.grid.Clear()
    }
    GetCellNumber(x,y)
    {
        cellX := Integer(x / (TILE_SIZE))
        cellY := Integer(y / (TILE_SIZE))
        answer := Integer(cellX + (cellY * (WINDOWS_SIZE / (TILE_SIZE))))
        return answer
    }
    GridAdd(who)
    {
        sector0 := this.GetCellNumber(who.centerX,who.centerY)
        ;sector1 := this.GetCellNumber(who.x1,who.y1)
        ;sector2 := this.GetCellNumber(who.x2,who.y2)
        ;sector3 := this.GetCellNumber(who.x1,who.y2)
        ;sector4 := this.GetCellNumber(who.x2,who.y1)
        
        /*
        if Type(this.grid[sector]) != "Array"
        {
            this.grid[sector] := []
        }
        */
        this.grid[sector0].Push(who)
        ;this.grid[sector1].Push(who)
        ;this.grid[sector2].Push(who)
        ;this.grid[sector3].Push(who)
        ;this.grid[sector4].Push(who)
        ;this.GridAddToAdjacentSectors(who,sector0)
    }
    GridAddToAdjacentSectors(who,sector)
    {
        sectors := [(sector - 10)]
        for nothing, sectorNumber in sectors
        {
            if 0 < sectorNumber <= this.grid.Capacity
            {
                this.grid[sectorNumber].Push(who)
            }
        }
    }
    Update()
    {
        loop this.grid.Capacity 
        {
            this.CheckCollision(A_Index)
        }
    }
}

class HitBox
{
    __New(parent) 
    {
        this.parent := parent
        this.x1 := this.parent.x
        this.y1 := this.parent.y
        this.width := TILE_SIZE
        this.height := TILE_SIZE
        this.x2 := (this.x1 + TILE_SIZE)
        this.y2 := (this.y1 + TILE_SIZE)
        this.centerX := (this.x1 + Integer(this.width / 2))
        this.centerY := (this.y1 + Integer(this.height / 2))
        this.isFixed := this.parent.isFixed
        this.ReportToCollisionManager()
    }
    CollidesWith(other)
    {
        x1 := Max(this.x1, other.x1)
        y1 := Min(this.y1, other.y1)
        x2 := Min(this.x2, other.x2)
        y2 := Max(this.y2, other.y2)

        newX := this.centerX > other.centerX ? (other.x2 + 1) : (other.x1 - this.width)
        newY := this.centerY < other.centerY ? (other.y1 - this.height) : (other.y2 + 1)
        if this.isFixed = true 
        {
            return
        }
        this.parent.SetY(newY)
        if this.y1 = other.y2 + 1
        {
            this.parent.TouchesFloor()
            return
        }
        this.parent.SetX(newX)
    }
    ReportToCollisionManager()
    {
        API.game.currentScene.CollisionManager.GridAdd(this)
    }
    StayInScreen()
    {
        if this.parent.x < 0
        {
            this.parent.x := 0
        }
        if this.parent.x + this.width > WINDOWS_SIZE
        {
            this.parent.x := (WINDOWS_SIZE - this.width)
        }
    }
    TouchesFloor()
    {
        this.parent.TouchesFloor()
    }
    Update() 
    {
        this.StayInScreen()
        this.x1 := this.parent.x
        this.y1 := this.parent.y
        this.x2 := (this.x1 + this.width)
        this.y2 := (this.y1 + this.height)
        this.centerX := (this.x1 + (this.width / 2))
        this.centerY := (this.y1 + (this.height / 2))
        this.isFixed := this.parent.isFixed
        this.ReportToCollisionManager()
    }
}