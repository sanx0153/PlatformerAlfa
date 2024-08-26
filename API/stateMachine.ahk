ListLines()
class StateMachine
{
    __New()
    {
        this.StatesMap         := Map()
        this.StatesMap.Default := "off"
        this.presentState      := this.StatesMap.Default
        this.nextState         := "off"
    }
    Call()
    {
        this.Run()
    }
    AddState(stateName)
    {
        this.StatesMap[stateName] := ""
    }
    ChangeState(stateName)
    {
        this.presentState := stateName
    }
    Error(function,var)
    {
        MsgBox(function " received " Type(var) " type, " var " value.","Error","t3")
    }
    Forward()
    {
        this.ChangeState(this.nextState)
    }
    Off()
    {
        MsgBox(A_ThisFunc)
    }
    SetNextState(stateName)
    {
        stateIsValid := this.ValidateState(stateName)
        if stateIsValid  = true
        {
            this.nextState := stateName
        }
    }
    ValidateState(stateToTest)
    {
        stateIsValid := ""
        for key, value in this.StatesMap
        {
            if key = stateToTest
            {
                stateIsValid := true
                break
            }
            else
            {
                stateIsValid := false
            }
        }
        if stateIsValid = false
        {
            this.Error(A_ThisFunc,stateIsValid)
        }
        return stateIsValid
    }
    Run()
    {
        myState := this.ValidateState(this.presentState) ? this.presentState : this.StatesMap.Default
        this.%myState%()
    }
}