
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x12c, %r11d           # imm = 0x12C
               	movl	$0x12345, %r9d          # imm = 0x12345
               	xorq	%r8, %r8
               	movl	%r8d, -0x18(%rbp)
               	movl	%r8d, -0x20(%rbp)
               	movl	%r8d, -0x28(%rbp)
               	jmp	0x400262 <.text+0x42>
               	movslq	-0x18(%rbp), %r8
               	cmpq	$0x3, %r8
               	jge	0x4002b8 <.text+0x98>
               	movslq	-0x20(%rbp), %rdi
               	movq	%r11, %r8
               	andq	$0xff, %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x20(%rbp)
               	movslq	-0x28(%rbp), %r8
               	movq	%r9, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	addq	%rdi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x28(%rbp)
               	movslq	-0x18(%rbp), %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x18(%rbp)
               	jmp	0x400262 <.text+0x42>
               	xorq	%rdi, %rdi
               	movl	%edi, -0x30(%rbp)
               	andq	$0xff, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	0x4002f9 <.text+0xd9>
               	movslq	-0x30(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x30(%rbp)
               	jmp	0x4002f9 <.text+0xd9>
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	xorq	$0x2345, %r9            # imm = 0x2345
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x400334 <.text+0x114>
               	movslq	-0x30(%rbp), %r11
               	addq	$0x2, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x30(%rbp)
               	jmp	0x400334 <.text+0x114>
               	movslq	-0x20(%rbp), %r11
               	movl	$0x84, %r9d
               	movslq	%r9d, %r9
               	cmpq	%r9, %r11
               	je	0x400361 <.text+0x141>
               	movslq	-0x30(%rbp), %r9
               	addq	$0x4, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x30(%rbp)
               	jmp	0x400361 <.text+0x141>
               	movslq	-0x28(%rbp), %r9
               	movl	$0x69cf, %r11d          # imm = 0x69CF
               	movslq	%r11d, %r11
               	cmpq	%r11, %r9
               	je	0x40038e <.text+0x16e>
               	movslq	-0x30(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x30(%rbp)
               	jmp	0x40038e <.text+0x16e>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
