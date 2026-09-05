
computed_goto_const_static_table.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<interp_ptr_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, -0x10(%rbp)
               	leaq	(%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<interp_decl_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, -0x10(%rbp)
               	leaq	(%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<interp_long>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	%rdi, -0x20(%rbp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	%eax, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, -0x10(%rbp)
               	leaq	(%rdi), %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	addq	%rdi, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	-0x20(%rbp), %rcx
               	movslq	-0x10(%rbp), %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	movl	%edx, -0x8(%rbp)
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	-0x20(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rbx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
