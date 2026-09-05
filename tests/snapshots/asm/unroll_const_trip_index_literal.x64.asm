
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
               	leaq	(%rdi), %rax
               	movl	$0x1, %edx
               	movl	%edx, (%rax)
               	movq	%rsi, 0x20(%rax)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x30(%rdi)
               	leaq	0x30(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x60(%rdi)
               	leaq	0x60(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x4(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0x90(%rdi)
               	leaq	0x90(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x3, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %edx
               	movl	%edx, 0xc0(%rdi)
               	leaq	0xc0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x4, %r8d
               	movl	%r8d, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	%edx, 0xf0(%rdi)
               	leaq	0xf0(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x5, %edx
               	movl	%edx, 0x4(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x120(%rdi)
               	leaq	0x120(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x4(%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x28(%rax)
               	movl	%ecx, 0x150(%rdi)
               	leaq	0x150(%rdi), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	movq	%rdx, 0x28(%rax)
               	leaq	0x180(%rdi), %rcx
               	leaq	(%rcx), %rax
               	movl	$0x2, %edx
               	movl	%edx, (%rax)
               	movq	%rsi, 0x20(%rax)
               	movl	$0x20, %edx
               	movl	%edx, 0x4(%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	0x180(%rdi), %rcx
               	leaq	(%rcx), %rax
               	movl	$0xb00, %edx            # imm = 0xB00
               	movq	%rdx, 0x10(%rax)
               	movl	$0x2, %eax
               	movl	%eax, 0x30(%rcx)
               	leaq	0x30(%rcx), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x21, %edx
               	movl	%edx, 0x4(%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x28(%rax)
               	movl	$0x1600, %ecx           # imm = 0x1600
               	movq	%rcx, 0x10(%rax)
               	leaq	0x180(%rdi), %rcx
               	movl	$0x2, %eax
               	movl	%eax, 0x60(%rcx)
               	leaq	0x60(%rcx), %rax
               	movq	%rsi, 0x20(%rax)
               	movl	$0x22, %edx
               	movl	%edx, 0x4(%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x28(%rax)
               	movl	$0x2100, %ecx           # imm = 0x2100
               	movq	%rcx, 0x10(%rax)
               	movq	%rdx, %rax
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
               	movslq	%eax, %rcx
               	imulq	$0x30, %rcx, %rsi
               	leaq	(%rbx,%rsi), %rdx
               	movl	(%rdx), %edi
               	xorq	$0x1, %rdi
               	movl	%edi, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	0x20(%rdx), %rdi
               	cmpq	%r13, %rdi
               	setne	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	0x4(%rdx), %edx
               	movl	%ecx, %edi
               	cmpl	%edi, %edx
               	jne	<addr>
               	leaq	(%rbx,%rsi), %rdx
               	movq	0x28(%rdx), %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leaq	<rip>, %rdi
               	jmp	<addr>
               	leaq	0x180(%rbx), %r8
               	movslq	%eax, %rcx
               	imulq	$0x30, %rcx, %rdx
               	leaq	(%r8,%rdx), %rsi
               	movl	(%rsi), %r9d
               	xorq	$0x2, %r9
               	movl	%r9d, %r9d
               	testq	%r9, %r9
               	jne	<addr>
               	movq	0x20(%rsi), %rsi
               	cmpq	%r13, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x180(%rbx), %rsi
               	addq	%rsi, %rdx
               	movl	0x4(%rdx), %r8d
               	leaq	0x20(%rcx), %rdx
               	movl	%edx, %edx
               	cmpl	%edx, %r8d
               	jne	<addr>
               	imulq	$0x30, %rcx, %r8
               	leaq	(%rsi,%r8), %rdx
               	movq	0x28(%rdx), %r9
               	testq	%r9, %r9
               	jne	<addr>
               	movq	0x10(%rdx), %rdx
               	movslq	(%rdi,%rcx,4), %rsi
               	shlq	$0x8, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x180(%rbx), %rdx
               	imulq	$0x30, %rcx, %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rdx), %rdx
               	addq	%rdx, %r12
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	cmpq	$0x4200, %r12           # imm = 0x4200
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	movslq	(%rsi,%rcx,4), %r8
               	shlq	$0x8, %r8
               	addq	%r8, %rdx
               	leaq	0x1(%rcx), %rax
               	movslq	(%rdi), %rcx
               	cmpl	%ecx, %eax
               	jl	<addr>
               	cmpq	%r12, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
