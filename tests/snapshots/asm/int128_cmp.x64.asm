
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
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	xorl	%esi, %esi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rcx
               	orq	%rsi, %rcx
               	movq	(%rdx), %rdx
               	movq	(%rdi), %rdi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %r8
               	addq	%r8, %rdi
               	movq	%rsi, %r8
               	orq	%rdi, %r8
               	movq	(%rbx), %rdi
               	testq	%rdi, %rdi
               	seta	%r12b
               	movzbq	%r12b, %r12
               	movq	%rsi, %r9
               	subq	%rdi, %r9
               	xorl	%esi, %esi
               	subq	%r12, %rsi
               	movq	(%rbx), %rdi
               	shlq	$0x3f, %rdi
               	movq	(%rbx), %rbx
               	movq	%rcx, %r12
               	xorq	%rcx, %r12
               	movq	%rax, %r13
               	xorq	%rax, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movq	%rcx, %r12
               	xorq	%rcx, %r12
               	movq	%rax, %r13
               	xorq	%rax, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%rcx, %r12
               	xorq	%r8, %r12
               	movq	%rax, %r13
               	xorq	%rdx, %r13
               	orq	%r13, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %r12
               	shlq	$0x3f, %r12
               	xorq	%rax, %r12
               	movq	%rcx, %r13
               	xorq	%rcx, %r13
               	xorq	%rax, %r12
               	orq	%r13, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	cmpq	%rdx, %rax
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rdx, %rax
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%r8, %rcx
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r12
               	testl	%r12d, %r12d
               	je	<addr>
               	cmpq	%rax, %rdx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	cmpq	%rax, %rdx
               	sete	%r13b
               	movzbq	%r13b, %r13
               	cmpq	%rcx, %r8
               	setb	%r14b
               	movzbq	%r14b, %r14
               	andq	%r14, %r13
               	orq	%r13, %r12
               	testl	%r12d, %r12d
               	jne	<addr>
               	cmpq	%rsi, %rax
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rsi, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%r9, %rcx
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %r8
               	orq	%r8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rax, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rcx, %rcx
               	seta	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rdx
               	orq	%r8, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r8
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	seta	%r12b
               	movzbq	%r12b, %r12
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%r8, %r8
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdx
               	orq	%r12, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	testl	%esi, %esi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testl	%esi, %esi
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rbx, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%rdx, %r12
               	orq	%r12, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	cmpq	%r9, %rbx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	andq	%r8, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	cmpq	%rsi, %rdi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rsi, %rdi
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%r9, %r9
               	seta	%r12b
               	movzbq	%r12b, %r12
               	andq	%rdx, %r12
               	orq	%r12, %r8
               	testl	%r8d, %r8d
               	je	<addr>
               	testq	%rdi, %rdi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%rdi, %rdi
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%rbx, %rbx
               	seta	%r13b
               	movzbq	%r13b, %r13
               	andq	%r13, %r12
               	orq	%r12, %r8
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	cmpq	%rdi, %rsi
               	setl	%r8b
               	movzbq	%r8b, %r8
               	testq	%r9, %r9
               	setb	%r12b
               	movzbq	%r12b, %r12
               	andq	%r12, %rdx
               	orq	%r8, %rdx
               	xorq	$0x1, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	testq	%rsi, %rsi
               	jbe	<addr>
               	testq	%rdi, %rdi
               	seta	%dl
               	movzbq	%dl, %rdx
               	testq	%rdi, %rdi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rbx, %rbx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rdi, %rsi
               	orq	%rsi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %r8
               	movq	(%r8), %rdx
               	movq	(%r8), %rsi
               	cmpq	%rsi, %rdx
               	setl	%r9b
               	movzbq	%r9b, %r9
               	cmpq	%rsi, %rdx
               	sete	%dil
               	movzbq	%dil, %rdi
               	orq	%rdi, %r9
               	testl	%r9d, %r9d
               	je	<addr>
               	cmpq	%rsi, %rdx
               	setb	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, %rdx
               	orq	%rdi, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdi
               	testq	%rax, %rax
               	setb	%r9b
               	movzbq	%r9b, %r9
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdi, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	andq	%rsi, %rdi
               	orq	%r9, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movq	(%r8), %rdi
               	testq	%rax, %rax
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rcx, %rdi
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rsi, %rax
               	orq	%r8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movq	(%rdx), %rax
               	movq	(%rdx), %rcx
               	xorq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
