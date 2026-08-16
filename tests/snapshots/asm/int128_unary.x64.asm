
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
               	subq	$0x130, %rsp            # imm = 0x130
               	xorq	%rax, %rax
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x130(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movq	%rcx, %rsi
               	shlq	$0x24, %rsi
               	leaq	-0xa0(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x120(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x130(%rbp), %rcx
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
               	leaq	-0x120(%rbp), %rax
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
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	movabsq	$-0x1, %rcx
               	xorq	$-0x1, %rsi
               	movq	%rax, %rdi
               	xorq	$-0x1, %rdi
               	cmpq	%rcx, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	%rcx, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x120(%rbp), %rax
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$-0x1000000000, %r11    # imm = 0xFFFFFFF000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x120(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rsi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x120(%rbp), %rax
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
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x120(%rbp), %rax
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
               	leaq	-0x130(%rbp), %rax
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
               	leaq	-0x120(%rbp), %rax
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
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x120(%rbp), %rax
               	leaq	-0x110(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x110(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	movq	(%rdx), %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	seta	%sil
               	movzbq	%sil, %rsi
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	xorq	%rax, %rax
               	subq	%rsi, %rax
               	movq	%rax, %rdi
               	sarq	$0x4, %rdi
               	movq	%rdx, %rcx
               	shrq	$0x4, %rcx
               	movq	%rax, %rsi
               	shlq	$0x3c, %rsi
               	orq	%rsi, %rcx
               	movabsq	$-0x1, %rsi
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
               	movl	$0x9, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	leaq	-0x120(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rcx
               	cmpq	%rax, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x130, %rsp            # imm = 0x130
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	-0x130(%rbp), %rax
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
