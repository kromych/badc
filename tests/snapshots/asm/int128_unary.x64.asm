
int128_unary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<chk>:
               	popq	%r10
               	subq	$0x40, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	movq	%rdx, %rsi
               	movq	%rcx, %rdi
               	movq	%r8, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	%rsi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rdx
               	xorq	%rsi, %rsi
               	leaq	-0x28(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rsi, 0x8(%rax)
               	cmpq	%rdi, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%ecx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	leaq	-0x78(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rdx
               	leaq	-0x88(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	shlq	$0x24, %rdx
               	leaq	-0x98(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	movq	0x8(%rcx), %rcx
               	xorq	%rax, %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movabsq	$-0x1, %rsi
               	xorq	$-0x1, %rcx
               	xorq	$-0x1, %rax
               	leaq	-0xb0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movl	$0x2, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rsi
               	testq	%rcx, %rcx
               	seta	%dl
               	movzbq	%dl, %rdx
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	subq	%r10, %rcx
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	subq	%r10, %rax
               	subq	%rdx, %rax
               	leaq	-0xc0(%rbp), %rdi
               	movq	%rcx, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movabsq	$-0x1000000000, %rdx    # imm = 0xFFFFFFF000000000
               	movl	$0x3, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
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
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
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
               	leaq	-0x10(%rbp), %rax
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
               	leaq	-0x20(%rbp), %rax
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
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x38(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movabsq	$0x1000000000, %rdx     # imm = 0x1000000000
               	movl	$0x8, %ecx
               	movq	%rcx, %r8
               	movq	%rdx, %rcx
               	movq	%rsi, %rdx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	movq	(%rbx), %rdx
               	leaq	-0x128(%rbp), %rax
               	movq	%rdx, (%rax)
               	xorq	%rcx, %rcx
               	movq	%rcx, 0x8(%rax)
               	testq	%rdx, %rdx
               	seta	%al
               	movzbq	%al, %rax
               	movq	%rdx, %r10
               	movq	%rcx, %rdx
               	subq	%r10, %rdx
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	subq	%rax, %rcx
               	leaq	-0x138(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	sarq	$0x4, %rdx
               	shrq	$0x4, %rcx
               	shlq	$0x3c, %rax
               	orq	%rcx, %rax
               	leaq	-0x148(%rbp), %rdi
               	movq	%rax, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	movabsq	$-0x1, %rsi
               	movl	$0x9, %ecx
               	movq	%rsi, %rdx
               	movq	%rcx, %r8
               	movq	%rsi, %rcx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
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
               	jmp	<addr>
