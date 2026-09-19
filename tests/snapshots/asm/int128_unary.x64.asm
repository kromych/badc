
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
               	xorq	%rax, %rax
               	leaq	-0x70(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x60(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	xorq	$0x0, %rsi
               	orq	$0x0, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rcx), %rcx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	subq	$0x0, %rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	movq	0x8(%rax), %rcx
               	xorq	$0x0, %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x8(%rax), %rcx
               	orq	$0x0, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	(%rdx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rax, %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	testq	%rsi, %rsi
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x8, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	leave
               	retq
               	movq	(%rdx), %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rdi
               	subq	%rdx, %rdi
               	movq	%rcx, %rdx
               	subq	%rsi, %rdx
               	movq	%rdx, %r8
               	sarq	$0x4, %r8
               	movq	%rdi, %rsi
               	shrq	$0x4, %rsi
               	movq	%rdx, %r9
               	shlq	$0x3c, %r9
               	orq	%rsi, %r9
               	movabsq	$-0x1, %rsi
               	cmpq	%rsi, %r9
               	jne	<addr>
               	cmpq	%rsi, %r8
               	je	<addr>
               	movl	$0x9, %esi
               	testq	%rsi, %rsi
               	je	<addr>
               	movslq	%esi, %rax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	cmpq	%rdx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdi, %rdi
               	seta	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movq	%rcx, %rax
               	leave
               	retq
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x70(%rbp), %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
