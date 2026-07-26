
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
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	xorq	%rdx, %rdx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	movq	%rdx, %rcx
               	orq	%rax, %rcx
               	movq	%rdi, %rax
               	orq	%rdx, %rax
               	movq	(%rsi), %rdi
               	movq	(%rbx), %rsi
               	leaq	<rip>, %r8
               	movq	(%r8), %r9
               	addq	%r9, %rsi
               	movq	%rdx, %r9
               	orq	%rsi, %r9
               	movq	%rdi, %rsi
               	orq	%rdx, %rsi
               	movq	(%r8), %r12
               	testq	%r12, %r12
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%r12, %r10
               	movq	%rdx, %r12
               	subq	%r10, %r12
               	xorq	%rdx, %rdx
               	movq	%rdi, %r10
               	movq	%rdx, %rdi
               	subq	%r10, %rdi
               	movq	(%r8), %r13
               	movq	%r13, %rdx
               	shlq	$0x3f, %rdx
               	movq	(%r8), %r13
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
               	xorq	%rsi, %r15
               	orq	%r15, %r14
               	testq	%r14, %r14
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movq	%rcx, %r14
               	xorq	%r9, %r14
               	movq	%rax, %r15
               	xorq	%rsi, %r15
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
               	movq	(%r8), %r15
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
               	cmpq	%rsi, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rsi, %rax
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
               	cmpq	%rax, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rax, %rsi
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
               	cmpq	%rax, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rax, %rsi
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
               	cmpq	%rax, %rsi
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rax, %rsi
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
               	cmpq	%rsi, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rsi, %rax
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
               	cmpq	%rsi, %rax
               	setb	%r14b
               	movzbq	%r14b, %r14
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r9, %rcx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rsi
               	orq	%r14, %rsi
               	movq	%rsi, %r14
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
               	cmpq	%rdi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rax
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r12, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%r8), %r9
               	cmpq	%rax, %r9
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rax, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%rcx, %rcx
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	movq	(%r8), %r9
               	testq	%r9, %r9
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%r9, %r9
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r14, %r14
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
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
               	testq	%rdi, %rdi
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r13, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %r9d
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdi, %rdi
               	setg	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%r12, %r13
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	$0x1, %esi
               	testq	%r9, %r9
               	jne	<addr>
               	cmpq	%rdi, %rdx
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r12, %r12
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rdx, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r13, %r13
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	cmpq	%rdx, %rdi
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rdi
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r12, %r12
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %r9d
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	setl	%sil
               	movzbq	%sil, %rsi
               	testq	%rdx, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	testq	%r13, %r13
               	seta	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	setne	%r9b
               	movzbq	%r9b, %r9
               	movl	$0x1, %esi
               	testq	%r9, %r9
               	jne	<addr>
               	cmpq	%rdx, %rdx
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x0, %r9
               	orq	%r9, %rsi
               	testq	%rsi, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	%rdx, %rdx
               	setl	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x0, %r9
               	orq	%r9, %rsi
               	xorq	$0x1, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	testq	%rdi, %rdi
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%rdi, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%r12, %r13
               	setb	%r9b
               	movzbq	%r9b, %r9
               	andq	%r9, %rdi
               	orq	%rdi, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	testq	%rdx, %rdx
               	seta	%sil
               	movzbq	%sil, %rsi
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%r13, %r13
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rdx
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
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
               	movq	(%r8), %rsi
               	xorq	%rdi, %rdi
               	movq	%rsi, %rdx
               	orq	%rdi, %rdx
               	movq	(%r8), %r9
               	movq	%r9, %rsi
               	orq	%rdi, %rsi
               	cmpq	%rsi, %rdx
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rsi, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x1, %r9
               	orq	%r9, %rdi
               	testq	%rdi, %rdi
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	%rsi, %rdx
               	setl	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rsi, %rdx
               	sete	%r9b
               	movzbq	%r9b, %r9
               	andq	$0x1, %r9
               	orq	%r9, %rdi
               	xorq	$0x1, %rdi
               	testq	%rdi, %rdi
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
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rsi, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	$0x1, %rdx
               	orq	%rdi, %rdx
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
               	sete	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rdx, %rcx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdi, %rdx
               	orq	%rdx, %rsi
               	movl	$0x1, %edx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	(%r8), %rdx
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
