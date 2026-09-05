
int128_struct_member.x64:	file format elf64-x86-64

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

<read_wide>:
               	leaq	0x10(%rdi), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1b0, %rsp            # imm = 0x1B0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	xorq	%rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	%rcx, %rbx
               	orq	%rdx, %rbx
               	movq	%rax, %r12
               	orq	%rcx, %r12
               	leaq	-0x80(%rbp), %rax
               	movq	%rbx, (%rax)
               	movq	%r12, 0x8(%rax)
               	leaq	-0x1a0(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	cmpl	$0x1, %edx
               	movl	$0x1, %edx
               	jne	<addr>
               	movslq	0x20(%rax), %rdx
               	cmpl	$0x2, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	0x10(%rax), %rdx
               	movq	0x18(%rax), %rsi
               	movq	%rdx, %rax
               	xorq	%rbx, %rax
               	movq	%rsi, %rdx
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rsi
               	movq	%rdx, %rax
               	xorq	%rbx, %rax
               	movq	%rsi, %rdx
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	xorq	$0x0, %rdx
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	xorq	%r11, %rax
               	orq	%rax, %rdx
               	testq	%rdx, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movabsq	$0x1000000000, %r11     # imm = 0x1000000000
               	cmpq	%r11, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	movq	%rbx, %rax
               	xorq	$0x4, %rax
               	movq	%r12, %rdx
               	xorq	$0x9, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	movq	%rbx, %rax
               	xorq	%rbx, %rax
               	movq	%r12, %rdx
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x1a0(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movl	$0x2, %ecx
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x130(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	movq	(%rdx), %rcx
               	movq	0x18(%rax), %rdi
               	leaq	0x3(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	incq	%rdi
               	addq	%rcx, %rdi
               	leaq	-0x80(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x130(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rdi
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	xorq	$0x7, %rcx
               	xorq	$0xa, %rdx
               	orq	%rdx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rcx
               	leaq	0x10(%rcx), %rsi
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	0x10(%rcx), %rax
               	movq	0x18(%rcx), %rsi
               	xorq	%rdx, %rax
               	xorq	%rsi, %rdx
               	orq	%rax, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x130(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	leaq	-0x130(%rbp), %rdi
               	leaq	0x10(%rdi), %rax
               	leaq	-0x1a0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	callq	<addr>
               	movq	%rax, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	leaq	-0x80(%rbp), %rax
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x1b0, %rsp            # imm = 0x1B0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
