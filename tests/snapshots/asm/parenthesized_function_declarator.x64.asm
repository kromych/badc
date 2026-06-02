
parenthesized_function_declarator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rax
               	retq
               	movslq	%edi, %rdi
               	leaq	<rip>, %rax
               	shlq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, (%rax)
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %r11d
               	addq	$0x1, %r11
               	movslq	%r11d, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%ebx, %rbx
               	cmpq	$0xb, %rbx
               	je	<addr>
               	movl	$0x1, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
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
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movq	%rax, -0x20(%rbp)
               	jmp	<addr>
               	movq	-0x20(%rbp), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %edi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
