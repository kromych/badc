
offsetof_multi_runtime_subscript.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x7, %rdx, %rdi
               	addq	%rcx, %rdi
               	shlq	%rdi
               	addq	$0x2, %rdi
               	imulq	$0xe, %rdx, %r8
               	movq	%rcx, %r9
               	shlq	%r9
               	addq	%r9, %r8
               	addq	$0x2, %r8
               	cmpq	%rdi, %r8
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x7, %rcx
               	jl	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rsi,%rsi,2), %r9
               	addq	%rdx, %r9
               	shlq	%r9
               	addq	%rcx, %r9
               	shlq	$0x2, %r9
               	addq	$0x48, %r9
               	imulq	$0x18, %rsi, %rbx
               	movq	%rdx, %r12
               	shlq	$0x3, %r12
               	addq	%r12, %rbx
               	movq	%rcx, %r12
               	shlq	$0x2, %r12
               	addq	%r12, %rbx
               	addq	$0x48, %rbx
               	cmpq	%r9, %rbx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	0x1(%rdx), %rdi
               	movslq	%edi, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	0x1(%rsi), %r8
               	movslq	%r8d, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x7, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xe, %rcx, %rdx
               	addq	$0x8, %rdx
               	imulq	$0x7, %rcx, %rsi
               	shlq	%rsi
               	addq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x18, %rdx, %rdi
               	movq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	%r8, %rdi
               	addq	$0x50, %rdi
               	imulq	$0x6, %rdx, %r8
               	addq	%rcx, %r8
               	shlq	$0x2, %r8
               	addq	$0x50, %r8
               	cmpq	%r8, %rdi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x2, %rcx
               	jl	<addr>
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	cmpq	$0x4, %rdx
               	jl	<addr>
               	xorq	%r8, %r8
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0x34, %r9, %rdx
               	leaq	0xac(%rdx), %rbx
               	leaq	(%rsi,%rsi,2), %r12
               	addq	%rcx, %r12
               	shlq	$0x2, %r12
               	addq	%r12, %rbx
               	imulq	$0xc, %rsi, %r12
               	addq	%r12, %rdx
               	movq	%rcx, %r12
               	shlq	$0x2, %r12
               	addq	%r12, %rdx
               	addq	$0xac, %rdx
               	cmpq	%rbx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x3, %rcx
               	jl	<addr>
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	$0x4, %rsi
               	jl	<addr>
               	leaq	0x1(%r9), %r8
               	movslq	%r8d, %r9
               	cmpq	$0x3, %r9
               	jl	<addr>
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
