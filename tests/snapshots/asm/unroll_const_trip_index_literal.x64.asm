
unroll_const_trip_index_literal.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bank_init>:
               	leaq	(%rdi), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	(%rdi), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	leaq	(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0x30(%rdi)
               	leaq	0x30(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x30(%rdi), %rax
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x30(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0x60(%rdi)
               	leaq	0x60(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x60(%rdi), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x60(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0x90(%rdi)
               	leaq	0x90(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x90(%rdi), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x90(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0xc0(%rdi)
               	leaq	0xc0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0xc0(%rdi), %rax
               	movl	$0x4, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0xc0(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0xf0(%rdi)
               	leaq	0xf0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0xf0(%rdi), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0xf0(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0x120(%rdi)
               	leaq	0x120(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x120(%rdi), %rax
               	movl	$0x6, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x120(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %eax
               	movl	%eax, 0x150(%rdi)
               	leaq	0x150(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x150(%rdi), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x150(%rdi), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x0, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x0, %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x0, %rax
               	movl	$0x20, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x0, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x0, %rax
               	movl	$0xb00, %ecx            # imm = 0xB00
               	movq	%rcx, 0x10(%rax)
               	leaq	0x180(%rdi), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x30, %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x30, %rax
               	movl	$0x21, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x30, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x30, %rax
               	movl	$0x1600, %ecx           # imm = 0x1600
               	movq	%rcx, 0x10(%rax)
               	leaq	0x180(%rdi), %rax
               	movl	$0x2, %ecx
               	movl	%ecx, 0x60(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	movl	$0x22, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	movl	$0x2100, %ecx           # imm = 0x2100
               	movq	%rcx, 0x10(%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%r12, %r12
               	leaq	<rip>, %rbx
               	leaq	<rip>, %r13
               	movq	%rbx, %rdi
               	movq	%r13, %rsi
               	callq	<addr>
               	movq	%r12, %rax
               	jmp	<addr>
               	imulq	$0x30, %rcx, %rdx
               	addq	%rbx, %rdx
               	movl	(%rdx), %edx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	imulq	$0x30, %rcx, %rdx
               	addq	%rbx, %rdx
               	movq	0x20(%rdx), %rdx
               	cmpq	%r13, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	imulq	$0x30, %rcx, %rdx
               	addq	%rbx, %rdx
               	movl	0x4(%rdx), %edx
               	movl	%ecx, %esi
               	cmpq	%rsi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	imulq	$0x30, %rcx, %rdx
               	addq	%rbx, %rdx
               	movq	0x28(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x8, %rcx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movl	(%rdx), %edx
               	xorq	$0x2, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rdx), %rdx
               	cmpq	%r13, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movl	0x4(%rdx), %esi
               	leaq	0x20(%rax), %rdx
               	movslq	%edx, %rdx
               	movl	%edx, %edx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rsi
               	leaq	<rip>, %rdx
               	movslq	(%rdx,%rax,4), %rdx
               	shlq	$0x8, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rax, %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %r12
               	jmp	<addr>
               	jmp	<addr>
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jl	<addr>
               	cmpq	$0x4200, %r12           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	(%rsi,%rcx,4), %rsi
               	shlq	$0x8, %rsi
               	addq	%rsi, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	jl	<addr>
               	cmpq	%r12, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
