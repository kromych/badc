
empty_macro_arg_and_string_rows.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x10, %eax
               	movl	$0x4, %ecx
               	pushq	%rdx
               	cqto
               	idivq	%rcx
               	popq	%rdx
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x17, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x68, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x4(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movzbq	0x5(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	0x6(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
