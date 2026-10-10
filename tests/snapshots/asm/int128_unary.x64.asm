
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
               	movq	%rax, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	shlq	$0x24, %rcx
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rcx
               	negq	%rcx
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	cmpq	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	leaq	-0x10(%rbp), %rax
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	testq	%rdx, %rdx
               	je	<addr>
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
               	movq	(%rcx), %rax
               	testq	%rax, %rax
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rax, %rdx
               	negq	%rdx
               	negq	%rcx
               	movq	%rcx, %rsi
               	sarq	$0x4, %rsi
               	movq	%rdx, %rax
               	shrq	$0x4, %rax
               	movq	%rcx, %rdi
               	shlq	$0x3c, %rdi
               	orq	%rax, %rdi
               	movq	$-0x1, %rax
               	cmpq	%rax, %rdi
               	jne	<addr>
               	cmpl	%eax, %esi
               	je	<addr>
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	%rcx, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	seta	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
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
