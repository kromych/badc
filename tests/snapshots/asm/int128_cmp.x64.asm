
int128_cmp.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rcx
               	orq	%rsi, %rcx
               	orq	%rsi, %rax
               	movq	(%rdx), %rdx
               	movq	(%rbx), %r8
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r9
               	addq	%r9, %r8
               	movq	%rsi, %r9
               	orq	%r8, %r9
               	orq	%rsi, %rdx
               	movq	(%rdi), %r8
               	testq	%r8, %r8
               	seta	%r13b
               	movzbq	%r13b, %r13
               	movq	%rsi, %r12
               	subq	%r8, %r12
               	xorq	%rsi, %rsi
               	subq	%r13, %rsi
               	movq	(%rdi), %r8
               	shlq	$0x3f, %r8
               	movq	(%rdi), %r13
               	movq	%rcx, %r14
               	xorq	%rcx, %r14
               	movq	%rax, %r15
               	xorq	%rax, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movq	%rcx, %r14
               	xorq	%rcx, %r14
               	movq	%rax, %r15
               	xorq	%rax, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movq	%rcx, %r14
               	xorq	%r9, %r14
               	movq	%rax, %r15
               	xorq	%rdx, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movq	(%rdi), %r14
               	shlq	$0x3f, %r14
               	movq	%rcx, %r15
               	xorq	$0x0, %r15
               	xorq	%rax, %r14
               	xorq	%rcx, %r15
               	xorq	%rax, %r14
               	orq	%r15, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	cmpq	%rdx, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rdx, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	%r9, %rcx
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	0x38(%rsp), %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	je	<addr>
               	cmpq	%rax, %rdx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rax, %rdx
               	sete	%r15b
               	movzbq	%r15b, %r15
               	cmpq	%rcx, %r9
               	setb	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	andq	0x38(%rsp), %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	cmpq	%rsi, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r12, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	(%rdi), %rdx
               	cmpq	%rax, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rax, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %rdx
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movq	(%rbx), %r9
               	movq	(%rdi), %rdx
               	testq	%rdx, %rdx
               	seta	%r14b
               	movzbq	%r14b, %r14
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%r9, %r9
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%r14, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	testq	%rsi, %rsi
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r13, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rsi, %rsi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r12, %r13
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	$0x0, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	%rsi, %r8
               	setl	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %r8
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r12, %r12
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%r8, %r8
               	setl	%dl
               	movzbq	%dl, %rdx
               	testq	%r8, %r8
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r13, %r13
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	cmpq	%r8, %rsi
               	setl	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r8, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	xorq	$0x1, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rsi, %rsi
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r12, %r13
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%r8, %r8
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%r8, %r8
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%r13, %r13
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movq	(%rdi), %rdx
               	xorq	%rsi, %rsi
               	orq	%rsi, %rdx
               	movq	(%rdi), %r8
               	orq	%r8, %rsi
               	cmpq	%rsi, %rdx
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rdx
               	sete	%r8b
               	movzbq	%r8b, %r8
               	orq	%r8, %r9
               	testq	%r9, %r9
               	je	<addr>
               	cmpq	%rsi, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, %rdx
               	orq	%r8, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movq	(%rbx), %rsi
               	testq	%rax, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %rcx
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rdx, %rsi
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%rdi), %rsi
               	testq	%rax, %rax
               	seta	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rsi
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rdx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rbx), %rax
               	movq	(%rbx), %rcx
               	xorq	%rcx, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	leave
               	retq
