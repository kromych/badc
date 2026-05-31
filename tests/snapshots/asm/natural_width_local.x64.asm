
natural_width_local.x64:	file format elf64-x86-64

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
               	movl	$0xc8, %r9d
               	xorq	%r8, %r8
               	movl	%r8d, -0x20(%rbp)
               	movl	%r8d, -0x28(%rbp)
               	jmp	0x40025e <.text+0x3e>
               	movslq	-0x20(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	0x40029c <.text+0x7c>
               	movslq	-0x28(%rbp), %r8
               	movsbq	%r11b, %rdi
               	movq	%r8, %rsi
               	addq	%rdi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x28(%rbp)
               	movslq	-0x20(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x20(%rbp)
               	jmp	0x40025e <.text+0x3e>
               	xorq	%rsi, %rsi
               	movl	%esi, -0x30(%rbp)
               	movsbq	%r11b, %rdi
               	cmpq	$0x2c, %rdi
               	je	0x4002cc <.text+0xac>
               	movslq	-0x30(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x4002cc <.text+0xac>
               	movq	%r11, %rsi
               	andq	$0xff, %rsi
               	movq	%rsi, %rdi
               	xorq	$0x2c, %rdi
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rdi, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40030e <.text+0xee>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x2, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x30(%rbp)
               	jmp	0x40030e <.text+0xee>
               	movsbq	%r9b, %rdi
               	cmpq	$-0x38, %rdi
               	je	0x400338 <.text+0x118>
               	movslq	-0x30(%rbp), %rdi
               	movq	%rdi, %rsi
               	addq	$0x4, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, -0x30(%rbp)
               	jmp	0x400338 <.text+0x118>
               	movslq	-0x28(%rbp), %rsi
               	cmpq	$0xb0, %rsi
               	je	0x400362 <.text+0x142>
               	movslq	-0x30(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x30(%rbp)
               	jmp	0x400362 <.text+0x142>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
