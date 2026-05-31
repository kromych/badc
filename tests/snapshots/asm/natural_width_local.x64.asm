
natural_width_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x12c, %r11d           # imm = 0x12C
               	movl	$0xc8, %r9d
               	xorq	%r8, %r8
               	movl	%r8d, -0x20(%rbp)
               	movl	%r8d, -0x28(%rbp)
               	jmp	<addr>
               	movslq	-0x20(%rbp), %r8
               	cmpq	$0x4, %r8
               	jge	<addr>
               	movslq	-0x28(%rbp), %rdi
               	movsbq	%r11b, %r8
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x28(%rbp)
               	movslq	-0x20(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x20(%rbp)
               	jmp	<addr>
               	xorq	%r8, %r8
               	movl	%r8d, -0x30(%rbp)
               	movsbq	%r11b, %rdi
               	cmpq	$0x2c, %rdi
               	je	<addr>
               	movslq	-0x30(%rbp), %r8
               	addq	$0x1, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x30(%rbp)
               	jmp	<addr>
               	andq	$0xff, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movslq	-0x30(%rbp), %rdi
               	addq	$0x2, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x30(%rbp)
               	jmp	<addr>
               	movsbq	%r9b, %r9
               	cmpq	$-0x38, %r9
               	je	<addr>
               	movslq	-0x30(%rbp), %r11
               	addq	$0x4, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x28(%rbp), %r11
               	cmpq	$0xb0, %r11
               	je	<addr>
               	movslq	-0x30(%rbp), %r9
               	addq	$0x8, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x30(%rbp)
               	jmp	<addr>
               	movslq	-0x30(%rbp), %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
