
int128_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chk>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	xorq	%rsi, %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	cmpq	%rdi, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	-0x78(%rbp), %rax
               	movq	%rcx, (%rax)
               	xorq	%r12, %r12
               	movq	%r12, 0x8(%rax)
               	leaq	-0x88(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	movq	%r12, %rdx
               	orq	%rax, %rdx
               	orq	%r12, %rcx
               	leaq	-0x98(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movabsq	$-0x8000000000000000, %rcx # imm = 0x8000000000000000
               	leaq	-0xa8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%r12, 0x8(%rax)
               	leaq	-0xb8(%rbp), %rax
               	movq	%r12, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%r12, %rdx
               	orq	$0x1, %rdx
               	orq	%r12, %rcx
               	leaq	-0xc8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	%r12d, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	(%rax), %rbx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %r9
               	movq	%rbx, %rcx
               	andq	$0x7f, %rcx
               	movq	%rbx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r13
               	subq	%rax, %r13
               	shrq	$0x6, %rcx
               	xorq	%rsi, %rsi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rdx, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shlq	%cl, %r8
               	popq	%rcx
               	pushq	%rcx
               	movq	%r13, %rcx
               	shrq	%cl, %rdx
               	popq	%rcx
               	shrq	%rdx
               	movq	%rax, %r10
               	movq	%r9, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	orq	%rdx, %rax
               	movq	%r8, %rdx
               	andq	%rdi, %rdx
               	andq	%rcx, %rsi
               	orq	%rsi, %rdx
               	andq	%rdi, %rax
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	leaq	-0xd8(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rdx
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x14(%rax), %rcx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %r9
               	movq	0x8(%rax), %rdx
               	movq	%rbx, %rcx
               	andq	$0x7f, %rcx
               	movq	%rbx, %rax
               	andq	$0x3f, %rax
               	movl	$0x3f, %esi
               	movq	%rsi, %r13
               	subq	%rax, %r13
               	shrq	$0x6, %rcx
               	xorq	%rsi, %rsi
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movq	%rcx, %rdi
               	xorq	$-0x1, %rdi
               	movq	%rdx, %r8
               	pushq	%rcx
               	movq	%rax, %rcx
               	shrq	%cl, %r8
               	popq	%rcx
               	pushq	%rcx
               	movq	%r13, %rcx
               	shlq	%cl, %rdx
               	popq	%rcx
               	shlq	%rdx
               	movq	%rax, %r10
               	movq	%r9, %rax
               	pushq	%rcx
               	movq	%r10, %rcx
               	shrq	%cl, %rax
               	popq	%rcx
               	orq	%rdx, %rax
               	andq	%rdi, %rax
               	movq	%r8, %rdx
               	andq	%rcx, %rdx
               	orq	%rdx, %rax
               	movq	%r8, %rdx
               	andq	%rdi, %rdx
               	andq	%rsi, %rcx
               	orq	%rdx, %rcx
               	leaq	-0xe8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rdx
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x1e(%rax), %rcx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	movq	%rbx, %rdx
               	andq	$0x7f, %rdx
               	movq	%rbx, %rcx
               	andq	$0x3f, %rcx
               	movl	$0x3f, %esi
               	movq	%rsi, %r9
               	subq	%rcx, %r9
               	shrq	$0x6, %rdx
               	xorq	%rsi, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	movq	%rdx, %rsi
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	sarq	%cl, %rdi
               	movq	%r9, %r10
               	movq	%rax, %r9
               	pushq	%rcx
               	movq	%r10, %rcx
               	shlq	%cl, %r9
               	popq	%rcx
               	shlq	%r9
               	movq	%rcx, %r10
               	movq	%r8, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%r9, %rcx
               	sarq	$0x3f, %rax
               	andq	%rsi, %rcx
               	movq	%rdi, %r8
               	andq	%rdx, %r8
               	orq	%r8, %rcx
               	andq	%rdi, %rsi
               	andq	%rdx, %rax
               	orq	%rsi, %rax
               	leaq	-0xf8(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rdx
               	movslq	%r12d, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rdx
               	leaq	0x28(%rax), %rcx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%r12d, %rax
               	leaq	0x1(%rax), %r12
               	movslq	%r12d, %rax
               	cmpq	$0x6, %rax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	leaq	-0x108(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movl	$0x1, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	%rdx
               	shlq	%rax
               	shrq	$0x3f, %rcx
               	orq	%rcx, %rax
               	leaq	-0x118(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rdx
               	movl	$0x2, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rcx, %rdx
               	shlq	$0x3f, %rdx
               	shlq	$0x3f, %rax
               	shrq	%rcx
               	orq	%rcx, %rax
               	leaq	-0x128(%rbp), %rdi
               	movq	%rdx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rdx
               	movl	$0x3, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	leaq	-0x138(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rdx
               	movl	$0x4, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	shlq	%rcx
               	leaq	-0x148(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x20(%rax), %rdx
               	movl	$0x5, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	shlq	$0x3f, %rcx
               	leaq	-0x158(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rdx
               	movl	$0x6, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shrq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	leaq	-0x168(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rdx
               	movl	$0x7, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rcx
               	leaq	-0x178(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rdx
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	shrq	$0x3f, %rax
               	xorq	%rcx, %rcx
               	leaq	-0x188(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rdx
               	movl	$0x9, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	sarq	%rdx
               	shrq	%rcx
               	shlq	$0x3f, %rax
               	orq	%rcx, %rax
               	leaq	-0x198(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rdx
               	movl	$0xa, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	leaq	-0x1a8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rdx
               	movl	$0xb, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	sarq	$0x3f, %rax
               	leaq	-0x1b8(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rdx
               	movl	$0xc, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %rdi
               	leaq	<rip>, %rcx
               	addq	$0xc, %rcx
               	movslq	(%rcx), %rcx
               	movq	%rcx, %rsi
               	andq	$0x7f, %rsi
               	andq	$0x3f, %rcx
               	movl	$0x3f, %r8d
               	movq	%r8, %r12
               	subq	%rcx, %r12
               	shrq	$0x6, %rsi
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	movq	%rsi, %r8
               	xorq	$-0x1, %r8
               	movq	%rdi, %r9
               	shrq	%cl, %r9
               	pushq	%rcx
               	movq	%r12, %rcx
               	shlq	%cl, %rdi
               	popq	%rcx
               	shlq	%rdi
               	movq	%rcx, %r10
               	movq	%rbx, %rcx
               	movq	%rcx, %r11
               	movq	%r10, %rcx
               	shrq	%cl, %r11
               	movq	%r11, %rcx
               	orq	%rdi, %rcx
               	andq	%r8, %rcx
               	movq	%r9, %rdi
               	andq	%rsi, %rdi
               	orq	%rdi, %rcx
               	movq	%r9, %rdi
               	andq	%r8, %rdi
               	andq	%rdx, %rsi
               	orq	%rdi, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x48(%rbp), %rdi
               	movq	(%r14), %rsi
               	movl	$0xd, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	popq	%rbp
               	retq
               	jmp	<addr>
