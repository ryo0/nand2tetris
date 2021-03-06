# DRYとか知らんがなのスタイルだが
# 流石に混乱しそうなのは分けた
def pop_segment(segment, index)
  <<-EOF
    // ↓R13に #{segment}+index を保存
    @#{segment}
    D=M
    @#{index}
    D=D+A
    @R13
    M=D
    // ↑R13に #{segment}+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
  EOF
end

def push_segment(segment, index)
  <<-EOF
  @#{segment}
  D=M
  @#{index}
  D=D+A
  A=D
  D=M
 EOF
end

class CodeWriter
  def initialize(filename)
    @filename = filename
    @function_name = ""
    @label_counter = -1
    @func_call_counter = -1
  end

  def write_push_pop(command, segment, index)
    if command == C_PUSH
      if segment == "constant"
        result = <<-EOF
          @#{index}
          D=A
        EOF
      elsif segment == "local"
        result = push_segment("LCL", index)
      elsif segment == "argument"
        result = push_segment("ARG", index)
      elsif segment == "this"
        result = push_segment("THIS", index)
      elsif segment == "that"
        result = push_segment("THAT", index)
      elsif segment == "temp"
        result = <<-EOF
          @R5
          D=A
          @#{index}
          D=D+A
          A=D
          D=M
        EOF
      elsif segment == "pointer"
        result = <<-EOF
          @R3
          D=A
          @#{index}
          D=D+A
          A=D
          D=M
        EOF
      elsif segment == "static"
        result = <<-EOF
          @#{@filename}.#{index}
          D=M
        EOF
      end
    # スタックポインタを増やす
    result +=
      <<-EOF
        @SP
        A=M
        M=D
        @SP
        M=M+1
      EOF
    elsif command == C_POP
      if segment == "local"
        pop_segment("LCL", index)
      elsif segment == "argument"
        pop_segment("ARG", index)
      elsif segment == "this"
        pop_segment("THIS", index)
      elsif segment == "that"
        pop_segment("THAT", index)
      elsif segment == "temp"
        <<-EOF
          @R5
          D=A
          @#{index}
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
        EOF
      elsif segment == "pointer"
        <<-EOF
          @R3
          D=A
          @#{index}
          D=D+A
          @R13
          M=D
          // ↑R13に R3+index を保存
          @SP
          M=M-1
          A=M
          D=M
          @R13
          A=M
          M=D
        EOF
      elsif segment == "static"
        <<-EOF
          @SP
          M=M-1
          A=M
          D=M
          @#{@filename}.#{index}
          M=D
        EOF
      end
    end
  end

  def write_label(label)
    <<-EOF
      (#{@function_name}$#{label})
    EOF
  end

  def write_goto(label)
    <<-EOF
      @#{@function_name}$#{label}
      0; JMP
    EOF
  end

  def write_if(label)
    <<-EOF
      @SP
      M=M-1
      A=M
      D=M
      @#{@function_name}$#{label}
      D; JNE
    EOF
  end

  def write_call(function_name, num_args)
    @func_call_counter += 1
    <<-EOF
      // push return-address
      @RET$#{@filename}$#{function_name}$#{@func_call_counter}
      D=A
      @SP
      A=M
      M=D
      @SP
      M=M+1
      // push LCL
      @LCL
      D=M
      @SP
      A=M
      M=D
      @SP
      M=M+1
      // push ARG
      @ARG
      D=M
      @SP
      A=M
      M=D
      @SP
      M=M+1
      // push THIS
      @THIS
      D=M
      @SP
      A=M
      M=D
      @SP
      M=M+1
      // push THAT
      @THAT
      D=M
      @SP
      A=M
      M=D
      @SP
      M=M+1
      // ARG=SP-n-5
      @#{num_args}
      D=A
      @5
      D=D+A
      @SP
      D=M-D
      @ARG
      M=D
      // LCL=SP
      @SP
      D=M
      @LCL
      M=D
      // goto f
      @#{function_name}
      0; JMP
    (RET$#{@filename}$#{function_name}$#{@func_call_counter})
    EOF
  end

  def write_return
    <<-EOF
      // FRAME=LCL
      @LCL
      D=M
      @R13
      M=D
      // R13にLCLが入った。
      // RET=*(FRAME-5)
      @LCL
      D=M
      @5
      D=D-A
      A=D
      D=M
      @R14
      M=D
      // R14にリターンアドレスが入った。
      // *ARG=POP()
      // ARGの位置にスタックから結果を格納
      @SP
      M=M-1
      A=M
      D=M
      @ARG
      A=M
      M=D
      // SP=ARG+1
      @ARG
      D=M
      @SP
      M=D+1
      // THAT=*(FRAME-1)
      @R13
      D=M
      @1
      D=D-A
      A=D
      D=M
      @THAT
      M=D
      // THIS=*(FRAME-2)
      @R13
      D=M
      @2
      D=D-A
      A=D
      D=M
      @THIS
      M=D
      // ARG=*(FRAME-3)
      @R13
      D=M
      @3
      D=D-A
      A=D
      D=M
      @ARG
      M=D
      // LCL=*(FRAME-4)
      @R13
      D=M
      @4
      D=D-A
      A=D
      D=M
      @LCL
      M=D
      // GOTO RET
      @R14
      A=M
      0; JMP
    EOF
  end

  def write_function(function_name, num_locals)
    @function_name = function_name
    p "(#{function_name})\n"
    result = "(#{function_name})\n"
    num_locals.times do
      result +=
          <<-EOF
              @0
              D=A
              @SP
              A=M
              M=D
              @SP
              M=M+1
          EOF
    end
    result
  end

  def write_arithmetic(command)
    case command
    when "add"
      <<-EOF
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
      EOF
    when "sub"
      <<-EOF
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
      EOF
    when "neg"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        D=-D
        M=D
        @SP
        M=M+1
      EOF
    when "eq"
    @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JEQ
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "gt"
      @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JGT
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "lt"
      @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JLT
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "and"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D&M
        M=D
        @SP
        M=M+1
      EOF
    when "or"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D|M
        M=D
        @SP
        M=M+1
      EOF
    when "not"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        D=!D
        M=D
        @SP
        M=M+1
      EOF
    end
  end
end
