
mem2reg_cross_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xe, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	<addr>
               	movslq	-0x10(%rbp), %r8
               	addq	%r11, %r8
               	movslq	%r8d, %r8
               	movl	%r8d, -0x10(%rbp)
               	movslq	-0x18(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x18(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
