
int128_struct_member.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	popq	%r10
               	subq	$0x20, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	leaq	0x10(%rdi), %rcx
               	movq	(%rcx), %rdx
               	movq	0x18(%rdi), %r8
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	addq	%rdx, %rsi
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	%r8, %rax
               	addq	%rax, %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	(%rdi), %rax
               	incq	%rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<read_wide>:
               	leaq	0x10(%rdi), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	andq	$-0x10, %rsp
               	subq	$0xd0, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rcx, %rbx
               	orq	%rax, %rbx
               	movq	%rdx, %r12
               	orq	%rcx, %r12
               	leaq	-0x120(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%r12, 0x8(%rax)
               	leaq	(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	%rbx, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	%rbx, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	$0x0, %rax
               	movabsq	$0x1000000000, %rcx     # imm = 0x1000000000
               	xorq	%rdx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rcx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	leaq	0x10(%rsp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rax
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	%rbx, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rbx, %rax
               	xorq	%rbx, %rax
               	movq	%r12, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	0x70(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	movl	$0x1, %eax
               	leaq	0x70(%rsp), %rcx
               	movl	%eax, (%rcx)
               	leaq	(%rsp), %rax
               	leaq	0x70(%rsp), %rcx
               	addq	$0x10, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x2, %ecx
               	leaq	0x70(%rsp), %rax
               	movl	%ecx, 0x20(%rax)
               	leaq	0x70(%rsp), %rdi
               	movl	$0x3, %eax
               	movl	$0x1, %ecx
               	leaq	-0x1b8(%rbp), %rsi
               	movq	%rax, (%rsi)
               	movq	%rcx, 0x8(%rsi)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	leaq	0x70(%rsp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x70(%rsp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	0x70(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, -0x1d0(%rbp)
               	movq	%rdx, -0x1c8(%rbp)
               	leaq	-0x1d0(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	$0x7, %rax
               	movq	%rdx, %rcx
               	xorq	$0xa, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	0x70(%rsp), %rax
               	leaq	0x10(%rax), %rdx
               	xorq	%rax, %rax
               	leaq	-0x210(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	0x70(%rsp), %rcx
               	movq	0x10(%rcx), %rdx
               	movq	0x18(%rcx), %rcx
               	xorq	%rax, %rdx
               	xorq	%rcx, %rax
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x70(%rsp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x70(%rsp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	leaq	0x70(%rsp), %rax
               	addq	$0x10, %rax
               	leaq	(%rsp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x70(%rsp), %rdi
               	callq	<addr>
               	movq	%rax, -0x230(%rbp)
               	movq	%rdx, -0x228(%rbp)
               	leaq	-0x230(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	%rcx, %rax
               	xorq	%rbx, %rax
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	xorq	%rbx, %rax
               	movq	%r12, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	leaq	-0x2a0(%rbp), %rsp
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
