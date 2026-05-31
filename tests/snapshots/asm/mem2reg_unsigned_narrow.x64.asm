
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
               	jge	0x4002c2 <.text+0xa2>
               	movslq	-0x20(%rbp), %r8
               	movq	%r11, %rdi
               	andq	$0xff, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x20(%rbp)
               	movslq	-0x28(%rbp), %rdi
               	movq	%r9, %rsi
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movq	%rdi, %r8
               	addq	%rsi, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x28(%rbp)
               	movslq	-0x18(%rbp), %rsi
               	movq	%rsi, %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x18(%rbp)
               	jmp	0x400262 <.text+0x42>
               	xorq	%r8, %r8
               	movl	%r8d, -0x30(%rbp)
               	movq	%r11, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%r11, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40030c <.text+0xec>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x30(%rbp)
               	jmp	0x40030c <.text+0xec>
               	movq	%r9, %r11
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movq	%r11, %rsi
               	xorq	$0x2345, %rsi           # imm = 0x2345
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rsi, %r11
               	cmpq	$0x0, %r11
               	je	0x40034f <.text+0x12f>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x40034f <.text+0x12f>
               	movslq	-0x20(%rbp), %rsi
               	movl	$0x84, %r11d
               	movslq	%r11d, %r11
               	cmpq	%r11, %rsi
               	je	0x40037f <.text+0x15f>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %r9
               	addq	$0x4, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x30(%rbp)
               	jmp	0x40037f <.text+0x15f>
               	movslq	-0x28(%rbp), %r9
               	movl	$0x69cf, %r11d          # imm = 0x69CF
               	movslq	%r11d, %r11
               	cmpq	%r11, %r9
               	je	0x4003ae <.text+0x18e>
               	movslq	-0x30(%rbp), %r11
               	movq	%r11, %rsi
               	addq	$0x8, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x4003ae <.text+0x18e>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
