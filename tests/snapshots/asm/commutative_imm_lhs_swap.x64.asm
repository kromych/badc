
commutative_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x7, %r11d
               	movq	%r11, %r9
               	shlq	$0x2, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x1c, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	addq	$0x3, %r9
               	movslq	%r9d, %r9
               	cmpq	$0xa, %r9
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	andq	$0xf0, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	orq	$0x10, %r9
               	cmpq	$0x17, %r9
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%r11, %r9
               	xorq	$0xff, %r9
               	cmpq	$0xf8, %r9
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x1, %r11
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x1, %r11
               	setne	%r9b
               	movzbq	%r9b, %r9
               	cmpq	$0x1, %r9
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %r9d
               	subq	%r11, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x3, %r9
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x8, %r11
               	setl	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
