
parenthesized_function_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	leaq	<rip>, %rax
               	shlq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, (%rax)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movl	$0xa, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x5, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movslq	%r12d, %r12
               	cmpq	$0xb, %r12
               	je	<addr>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x20(%rbp)
               	cmpq	$0x0, %r12
               	jne	<addr>
               	movslq	(%rax), %r14
               	cmpq	$0xa, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movq	%r14, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %r14
               	cmpq	$0x0, %r14
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
