
struct_member_copy_from_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<new_client>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	leaq	-0x20(%rbp), %rcx
               	xorq	%rax, %rax
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	leaq	<rip>, %rcx
               	leaq	-0x20(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	leaq	<rip>, %rdx
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	popq	%rax
               	leaq	-0x20(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movq	%rsi, 0x18(%rcx)
               	movl	$0x9, %ecx
               	movl	%ecx, (%rdx)
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rax, 0x10(%rcx)
               	movq	%rax, 0x18(%rcx)
               	leaq	-0x60(%rbp), %rax
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	leaq	-0x60(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	callq	<addr>
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	leaq	<rip>, %rax
               	leaq	-0x40(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x40(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
