
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
               	subq	$0x70, %rsp
               	xorq	%rcx, %rcx
               	leaq	-0x70(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	movq	%rax, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x60(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	0x8(%rax), %rsi
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	%rcx, %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rcx, %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	subq	$0x0, %rax
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rax
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
               	leaq	-0x60(%rbp), %rax
               	movq	0x8(%rax), %rsi
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %esi
               	cmpq	$0x1, %rsi
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x1, %esi
               	testq	%rsi, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rcx
               	orq	$0x0, %rcx
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
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x60(%rbp), %rax
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
               	leave
               	retq
               	movq	(%rdx), %rcx
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
               	leave
               	retq
               	leaq	-0x60(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	cmpq	%rcx, %rdx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rdx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rsi, %rsi
               	seta	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rdi, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leave
               	retq
               	movq	%rax, %rdx
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rsi
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
