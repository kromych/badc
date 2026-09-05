
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
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
               	leave
               	retq
               	movq	(%rdx), %rax
               	movq	0x8(%rdx), %rdx
               	movabsq	$-0x1, %rcx
               	xorq	$-0x1, %rax
               	xorq	$-0x1, %rdx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	%rcx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	-0xc0(%rbp), %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %r8
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	seta	%r9b
               	movzbq	%r9b, %r9
               	movq	%rdx, %rsi
               	subq	%rax, %rsi
               	movq	%rdx, %rax
               	subq	%r8, %rax
               	movq	%rax, %r8
               	subq	%r9, %r8
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rdx, %rsi
               	xorq	%rdx, %rcx
               	orq	%rsi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rdx
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rax, %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0xd0(%rbp), %rdx
               	movq	(%rdx), %rsi
               	movq	0x8(%rdx), %rdx
               	orq	%rsi, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rdi), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xc0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
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
               	movq	%rcx, %r8
               	sarq	$0x4, %r8
               	movq	%rsi, %rdx
               	shrq	$0x4, %rdx
               	movq	%rcx, %rdi
               	shlq	$0x3c, %rdi
               	orq	%rdi, %rdx
               	movabsq	$-0x1, %rdi
               	cmpq	%rdi, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	cmpq	%rdi, %r8
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%edx, %rax
               	leave
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
               	leave
               	retq
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0xd0(%rbp), %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
