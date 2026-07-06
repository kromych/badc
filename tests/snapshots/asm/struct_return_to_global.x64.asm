
struct_return_to_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rdi, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<store_global>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	<rip>, %rax
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rbx
               	movl	$0x6, %eax
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x60(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x60(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rbx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rbx)
               	popq	%rcx
               	movq	%rbx, %rax
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	addq	$0x0, %rax
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movslq	%edx, %rsi
               	movq	%rsi, %rdi
               	shlq	$0x4, %rdi
               	addq	%rdi, %rcx
               	imulq	$0xa, %rsi, %rsi
               	movslq	%esi, %rsi
               	leaq	-0x70(%rbp), %rdi
               	movq	%rsi, (%rdi)
               	leaq	-0x70(%rbp), %rsi
               	movl	$0x1, %edi
               	movq	%rdi, 0x8(%rsi)
               	leaq	-0x70(%rbp), %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movslq	%edx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x0, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	addq	$0x20, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	addq	$0x30, %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	leaq	(%rax,%rcx), %r12
               	leaq	-0x48(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	addq	%r12, %rax
               	cmpq	$0x4e, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
