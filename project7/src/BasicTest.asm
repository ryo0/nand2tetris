          @10
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
    // ↓R13に LCL+index を保存
    @LCL
    D=M
    @0
    D=D+A
    @R13
    M=D
    // ↑R13に LCL+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
          @21
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
          @22
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
    // ↓R13に ARG+index を保存
    @ARG
    D=M
    @2
    D=D+A
    @R13
    M=D
    // ↑R13に ARG+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
    // ↓R13に ARG+index を保存
    @ARG
    D=M
    @1
    D=D+A
    @R13
    M=D
    // ↑R13に ARG+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
          @36
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
    // ↓R13に THIS+index を保存
    @THIS
    D=M
    @6
    D=D+A
    @R13
    M=D
    // ↑R13に THIS+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
          @42
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
          @45
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
    // ↓R13に THAT+index を保存
    @THAT
    D=M
    @5
    D=D+A
    @R13
    M=D
    // ↑R13に THAT+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
    // ↓R13に THAT+index を保存
    @THAT
    D=M
    @2
    D=D+A
    @R13
    M=D
    // ↑R13に THAT+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
          @510
          D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
          @R5
          D=A
          @6
          D=D+A
          @R13
          M=D
          // ↑R13に R5+index を保存
          @SP
          M=M-1
          A=M
          D=M
          @R13
          A=M
          M=D
  @LCL
  D=M
  @0
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
  @THAT
  D=M
  @5
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
  @ARG
  D=M
  @1
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        M=D
        @SP
        M=M+1
  @THIS
  D=M
  @6
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
  @THIS
  D=M
  @6
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        M=D
        @SP
        M=M+1
          @R5
          D=A
          @6
          D=D+A
          @R13
          M=D
          // R13にtemp+indexの指す位置が格納された。
          @R13
          A=M
          D=M
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
