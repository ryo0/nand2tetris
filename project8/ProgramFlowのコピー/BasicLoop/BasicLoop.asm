          @0
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
      (LOOP_START)
  @ARG
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
  @ARG
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
          @1
          D=A
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
    // ↓R13に ARG+index を保存
    @ARG
    D=M
    @0
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
  @ARG
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
      @SP
      M=M-1
      A=M
      D=M
      @LOOP_START
      D; JNE
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
