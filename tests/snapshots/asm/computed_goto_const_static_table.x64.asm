
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
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<interp_decl_const>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<interp_long>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, 0x10(%rbp)
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movl	%ecx, -0x10(%rbp)
               	leaq	<rip>, %rax
               	movslq	%ecx, %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, -0x10(%rbp)
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rdi
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rcx
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
               	movq	0x10(%rbp), %rdx
               	movslq	-0x10(%rbp), %rcx
               	leaq	0x1(%rcx), %rsi
               	movl	%esi, -0x10(%rbp)
               	addq	%rdx, %rcx
               	movzbq	(%rcx), %rcx
               	movq	(%rax,%rcx,8), %rcx
               	jmpq	*%rcx
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
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
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
