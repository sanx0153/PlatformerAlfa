class line {
    line := []
    Add(&object,method) {
        this.line.Push([object,method])
    }
}

class Queue extends line {
    Run() {
        if this.line.Length = 0
            return
        while this.line.Length > 0 {
            currentItem := this.line.RemoveAt(1)
            currentItem[1].%currentItem[2]%()
        }
    }
}

class Stack extends line {
    Run() {
        if this.line.Length = 0
            return
        while this.line.Length > 0 {
            currentItem := this.line.Pop()
            currentItem[1].%currentItem[2]%()
        }
    }
}

/*
# Example Usage:
class test {
    works() {
        MsgBox("foi porra!!!!")
    }
}

fila := Queue()
teste := test()
fila.add(&teste,"works")
fila.Run()
*/