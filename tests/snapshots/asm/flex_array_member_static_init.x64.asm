
flex_array_member_static_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	0x18(%rax), %rcx
               	movslq	%edx, %rsi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rsi
               	movslq	%edx, %rdi
               	addq	%rdi, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movslq	%edx, %rsi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rax, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jne	<addr>
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x6, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	movl	$0x28, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1e(%rdx), %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xa(%rdx), %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
