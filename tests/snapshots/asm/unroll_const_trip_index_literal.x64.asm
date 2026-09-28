
unroll_const_trip_index_literal.x64:	file format elf64-x86-64

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

<bank_init>:
               	movl	$0x1, (%rdi)
               	movq	%rsi, 0x20(%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	$0x0, 0x28(%rdi)
               	movl	$0x1, 0x30(%rdi)
               	leaq	0x30(%rdi), %rdx
               	movq	%rsi, 0x20(%rdx)
               	movl	$0x1, 0x4(%rdx)
               	movq	$0x0, 0x28(%rdx)
               	movl	$0x1, 0x60(%rdi)
               	leaq	0x60(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x2, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0x90(%rdi)
               	leaq	0x90(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x3, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0xc0(%rdi)
               	leaq	0xc0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x4, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movl	$0x1, 0xf0(%rdi)
               	leaq	0xf0(%rdi), %rcx
               	movq	%rsi, 0x20(%rcx)
               	movl	$0x5, 0x4(%rcx)
               	movq	$0x0, 0x28(%rcx)
               	movl	$0x1, 0x120(%rdi)
               	leaq	0x120(%rdi), %rcx
               	movq	%rsi, 0x20(%rcx)
               	movl	$0x6, 0x4(%rcx)
               	movq	$0x0, 0x28(%rcx)
               	movl	$0x1, 0x150(%rdi)
               	leaq	0x150(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x7, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	leaq	0x180(%rdi), %rax
               	movl	$0x2, (%rax)
               	movq	%rsi, 0x20(%rax)
               	movl	$0x20, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0xb00, 0x10(%rax)      # imm = 0xB00
               	movl	$0x2, 0x30(%rax)
               	addq	$0x30, %rax
               	movq	%rsi, 0x20(%rax)
               	leaq	0x180(%rdi), %rdx
               	leaq	0x30(%rdx), %rax
               	movl	$0x21, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x1600, 0x10(%rax)     # imm = 0x1600
               	movl	$0x2, 0x60(%rdx)
               	leaq	0x180(%rdi), %rax
               	addq	$0x60, %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x22, 0x4(%rax)
               	movq	$0x0, 0x28(%rax)
               	movq	$0x2100, 0x10(%rax)     # imm = 0x2100
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rcx
               	movl	(%rcx), %esi
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	movq	0x20(%rcx), %rsi
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	movl	0x4(%rcx), %ecx
               	cmpl	%eax, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	%rdx, %rcx
               	cmpq	$0x0, 0x28(%rcx)
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx
               	leaq	0x180(%rdx), %rsi
               	imulq	$0x30, %rax, %rdx
               	addq	%rdx, %rsi
               	movl	(%rsi), %edi
               	xorq	$0x2, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	movq	0x20(%rsi), %rsi
               	leaq	<rip>, %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	<rip>, %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	addq	%rdx, %rsi
               	movl	0x4(%rsi), %edi
               	leaq	0x20(%rax), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	cmpq	$0x0, 0x28(%rsi)
               	jne	<addr>
               	leaq	<rip>, %rsi
               	addq	$0x180, %rsi            # imm = 0x180
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rdi,%rax,4), %rdi
               	shlq	$0x8, %rdi
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	imulq	$0x30, %rax, %rdx
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %rcx           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movslq	(%rsi,%rax,4), %rsi
               	shlq	$0x8, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rsi
               	cmpl	%esi, %eax
               	jl	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
