
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
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0xa, %r11d
               	addq	$0x1, %r11
               	movslq	%r11d, %rbx
               	movl	$0x5, %r12d
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%ebx, %rbx
               	cmpq	$0xb, %rbx
               	je	<addr>
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x0, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	movq	%rbx, -0x20(%rbp)
               	cmpq	$0x0, %rbx
               	jne	<addr>
               	movslq	(%rax), %r12
               	cmpq	$0xa, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
