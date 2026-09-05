
int128_unary.x64:	file format elf64-x86-64

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
               	subq	$0xd0, %rsp
               	xorq	%rcx, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xd0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %rsi
               	shlq	$0x24, %rsi
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	leaq	-0xc0(%rbp), %rsi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %r8
               	xorq	%rcx, %rax
               	xorq	%rcx, %r8
               	orq	%r8, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	(%rsi), %rax
               	movq	0x8(%rsi), %rsi
               	xorq	%rcx, %rax
               	xorq	%rsi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdx), %rcx
               	movq	0x8(%rdx), %rdx
               	movabsq	$-0x1, %rax
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rdx
               	cmpq	%rax, %rcx
               	jne	<addr>
               	cmpq	%rax, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	seta	%r8b
               	movzbq	%r8b, %r8
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movq	%rsi, %r10
               	movq	%rdx, %rsi
               	subq	%r10, %rsi
               	subq	%r8, %rsi
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xd0(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rdx, %rsi
               	xorq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rcx, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rdx
               	orq	%rsi, %rdx
               	movl	$0x1, %esi
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %r8
               	orq	%r8, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rsi
               	testq	%rsi, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	(%rdi), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	(%rdi), %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	subq	%rcx, %rsi
               	movq	%rax, %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdi
               	sarq	$0x4, %rdi
               	movq	%rsi, %rdx
               	shrq	$0x4, %rdx
               	movq	%rcx, %r8
               	shlq	$0x3c, %r8
               	orq	%rdx, %r8
               	movabsq	$-0x1, %rdx
               	cmpq	%rdx, %r8
               	jne	<addr>
               	cmpq	%rdx, %rdi
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0xc0(%rbp), %rdx
               	movq	(%rdx), %rdi
               	movq	0x8(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rcx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rsi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%r8, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0xd0(%rbp), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
