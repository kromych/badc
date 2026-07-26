
int128_unary.x64:	file format elf64-x86-64

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
               	subq	$0x170, %rsp            # imm = 0x170
               	subq	$0x40, %rsp
               	andq	$-0x10, %rsp
               	xorq	%rax, %rax
               	leaq	-0x78(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	(%rsp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	shlq	$0x24, %rsi
               	leaq	-0x98(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	0x10(%rsp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	(%rsp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	xorq	%rax, %rsi
               	xorq	%rcx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$-0x1, %rsi
               	xorq	$-0x1, %rcx
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	cmpq	%rsi, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	%rsi, %rdi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	seta	%dil
               	movzbq	%dil, %rdi
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	subq	%rsi, %rax
               	movq	%rax, %rsi
               	subq	%rdi, %rsi
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rax, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rax, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
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
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x10(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	0x20(%rsp), %rax
               	movq	(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	movq	(%rdx), %rcx
               	xorq	%rdx, %rdx
               	testq	%rcx, %rcx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rdx, %rsi
               	subq	%rcx, %rsi
               	xorq	%rcx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %r8
               	sarq	$0x4, %r8
               	movq	%rsi, %rax
               	shrq	$0x4, %rax
               	movq	%rcx, %rdx
               	shlq	$0x3c, %rdx
               	orq	%rax, %rdx
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
               	movl	$0x9, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	leaq	0x10(%rsp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x170(%rbp), %rsp
               	addq	$0x170, %rsp            # imm = 0x170
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	(%rsp), %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
