// じゅんび
@256
D=A
@SP
M=D
@300
D=A
@LCL
M=D
@400
D=A
@ARG
M=D
// じゅんび2
// スタックに値を積んでおく
@21
D=A
@SP
A=M
M=D
@SP
M=M+1
// ↓R13に ARG+index を保存
@ARG
D=M
@3 //index
D=D+A
@R13
M=D
// ↑R13に ARG+index を保存
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D
