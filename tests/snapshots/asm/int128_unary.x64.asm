
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
               	subq	$0x20, %rsp
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, %rdx
               	shlq	$0x24, %rdx
               	leaq	-0x10(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	0x8(%rcx), %rdx
               	negq	%rdx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	cmpq	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	cmpq	$0x0, 0x8(%rcx)
               	je	<addr>
               	leaq	-0x10(%rbp), %rcx
               	cmpq	$0x0, 0x8(%rcx)
               	je	<addr>
               	cmpq	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	cmpq	$0x0, (%rax)
               	movq	0x8(%rax), %rax
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rax, %rsi
               	negq	%rsi
               	negq	%rdx
               	movq	%rdx, %rdi
               	sarq	$0x4, %rdi
               	movq	%rsi, %rax
               	shrq	$0x4, %rax
               	movq	%rdx, %r8
               	shlq	$0x3c, %r8
               	orq	%rax, %r8
               	movq	$-0x1, %rax
               	cmpq	%rax, %r8
               	jne	<addr>
               	cmpl	%eax, %edi
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	0x8(%rcx), %rax
               	cmpq	%rdx, %rax
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rsi, %rsi
               	seta	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	jmp	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
