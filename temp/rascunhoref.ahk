#Requires AutoHotkey v2.0
#SingleInstance Force

var1 := 0
var2 := 0
while (var1 < 10) {
    MaisUm(&var1,&var2)
}
MaisUm(&var,&var2) {
    MsgBox("IsRef:" IsSetRef(&var),,"T1")
    var := var + 1
    MsgBox("Value:" var "value2:" var2,,"T1")
    if (var = 10) {
        var2 += var
        Reset(&var)
    }
}
Reset(&var) {
    MsgBox("IsRef:" IsSetRef(&var),,"T1")
    var := 0
    MsgBox("Value1:" var,,"T1")
}
