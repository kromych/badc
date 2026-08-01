
int128_cmp.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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
               	movq	(%rdx), %rdi
               	xorq	%rsi, %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	movq	%rsi, %rcx
               	orq	%rax, %rcx
               	movq	%rdi, %rax
               	orq	%rsi, %rax
               	movq	(%rdx), %r8
               	movq	(%rbx), %rdx
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r9
               	addq	%r9, %rdx
               	movq	%rsi, %r9
               	orq	%rdx, %r9
               	movq	%r8, %rdx
               	orq	%rsi, %rdx
               	movq	(%rdi), %r12
               	testq	%r12, %r12
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%r12, %r10
               	movq	%rsi, %r12
               	subq	%r10, %r12
               	xorq	%rsi, %rsi
               	subq	%r8, %rsi
               	movq	(%rdi), %r13
               	movq	%r13, %r8
               	shlq	$0x3f, %r8
               	movq	(%rdi), %r13
               	movq	%rcx, %r14
               	xorq	%rcx, %r14
               	movq	%rax, %r15
               	xorq	%rax, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movq	%rcx, %r14
               	xorq	%rcx, %r14
               	movq	%rax, %r15
               	xorq	%rax, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %r14
               	xorq	%r9, %r14
               	movq	%rax, %r15
               	xorq	%rdx, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movq	%rcx, %r14
               	xorq	%r9, %r14
               	movq	%rax, %r15
               	xorq	%rdx, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdi), %r15
               	shlq	$0x3f, %r15
               	movq	%rcx, %r10
               	xorq	$0x0, %r10
               	movq	%r10, 0x38(%rsp)
               	xorq	%rax, %r15
               	movq	%rcx, %r14
               	xorq	0x38(%rsp), %r14
               	xorq	%rax, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	sete	%r15b
               	movzbq	%r15b, %r15
               	movl	$0x1, %r14d
               	testq	%r15, %r15
               	jne	<addr>
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
               	setne	%r14b
               	movzbq	%r14b, %r14
               	movl	$0x1, %r15d
               	testq	%r14, %r14
               	jne	<addr>
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
               	xorq	$0x1, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	setne	%r15b
               	movzbq	%r15b, %r15
               	movl	$0x1, %r10d
               	movq	%r10, 0x38(%rsp)
               	testq	%r15, %r15
               	jne	<addr>
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
               	xorq	$0x1, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1, %r14d
               	movq	0x38(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
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
               	xorq	$0x1, %r14
               	testq	%r14, %r14
               	setne	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	cmpq	%rdx, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r9, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdx
               	orq	%r14, %rdx
               	movq	%rdx, %r14
               	xorq	$0x1, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rdi), %r9
               	cmpq	%rax, %r9
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rax, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %r14
               	movq	(%rdi), %r9
               	testq	%r9, %r9
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%r9, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r14, %r14
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %r9d
               	testq	%rdx, %rdx
               	jne	<addr>
               	testq	%rsi, %rsi
               	setg	%dl
               	movzbq	%dl, %rdx
               	testq	%rsi, %rsi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r12, %r13
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rdx
               	testq	%rdx, %rdx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	$0x1, %edx
               	testq	%r9, %r9
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %r9d
               	testq	%rdx, %rdx
               	jne	<addr>
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	$0x1, %edx
               	testq	%r9, %r9
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
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
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdi), %rsi
               	xorq	%r8, %r8
               	movq	%rsi, %rdx
               	orq	%r8, %rdx
               	movq	(%rdi), %r9
               	movq	%r9, %rsi
               	orq	%r8, %rsi
               	cmpq	%rsi, %rdx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x1, %r9
               	orq	%r9, %r8
               	testq	%r8, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	jne	<addr>
               	cmpq	%rsi, %rdx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x1, %r9
               	orq	%r9, %r8
               	xorq	$0x1, %r8
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rsi, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	$0x1, %rdx
               	orq	%r8, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rdx
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rdx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%r8, %rdx
               	orq	%rdx, %rsi
               	movl	$0x1, %edx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%rdi), %rdx
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rcx, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rbx), %rcx
               	movq	(%rbx), %rax
               	xorq	%rcx, %rax
               	orq	$0x0, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
