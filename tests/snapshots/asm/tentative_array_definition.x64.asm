
tentative_array_definition.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<take_never>:
               	leaq	<rip>, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%r12, %r12
               	leaq	<rip>, %rbx
               	movsbq	(%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	orq	$0x1, %r12
               	cmpq	%rbx, %rbx
               	je	<addr>
               	orq	$0x2, %r12
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x68, %rax
               	je	<addr>
               	orq	$0x4, %r12
               	xorq	%rbx, %rbx
               	leaq	<rip>, %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rdx
               	addq	%rdx, %rcx
               	movsbq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	movslq	%r12d, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	orq	$0x8, %r12
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r12d, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
