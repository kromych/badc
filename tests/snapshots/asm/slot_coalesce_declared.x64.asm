
slot_coalesce_declared.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<mkq>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rcx
               	movq	0x20(%rbp), %rax
               	movq	%rax, (%rcx)
               	leaq	-0x20(%rbp), %rcx
               	movq	%rax, %rdx
               	xorq	$0x5555, %rdx           # imm = 0x5555
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x9(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rcx
               	leaq	(%rax,%rax,2), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<useq>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sum8>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x18(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x20(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x28(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x30(%rax), %rax
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rax
               	movq	0x38(%rax), %rax
               	addq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<build>:
               	popq	%r10
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x10(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x140, %rsp            # imm = 0x140
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	0x20(%rbp), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	addq	%rax, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	%rbx, %rcx
               	leaq	0x1(%rcx), %rdx
               	leaq	0x2(%rcx), %rsi
               	leaq	0x3(%rcx), %rdi
               	leaq	0x4(%rcx), %r8
               	leaq	0x5(%rcx), %r9
               	leaq	0x6(%rcx), %rbx
               	leaq	0x7(%rcx), %r12
               	addq	%rcx, %rdx
               	addq	%rsi, %rdx
               	addq	%rdi, %rdx
               	addq	%r8, %rdx
               	addq	%r9, %rdx
               	addq	%rbx, %rdx
               	addq	%r12, %rdx
               	movq	0x10(%rbp), %rsi
               	leaq	-0x118(%rbp), %rdi
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rdi)
               	movq	0x30(%r8), %rax
               	movq	%rax, 0x30(%rdi)
               	movq	0x38(%r8), %rax
               	movq	%rax, 0x38(%rdi)
               	popq	%rax
               	movq	0x20(%rbp), %rdi
               	leaq	-0x118(%rbp), %r8
               	movq	%rdi, (%r8)
               	movq	0x20(%rbp), %rdi
               	leaq	0x1(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x8(%rdi)
               	movq	0x20(%rbp), %rdi
               	leaq	0x2(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x10(%rdi)
               	movq	0x20(%rbp), %rdi
               	leaq	0x3(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x18(%rdi)
               	movq	0x20(%rbp), %rdi
               	leaq	0x4(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x20(%rdi)
               	movq	0x20(%rbp), %rdi
               	leaq	0x5(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x28(%rdi)
               	movq	0x20(%rbp), %rdi
               	leaq	0x6(%rdi), %r8
               	leaq	-0x118(%rbp), %rdi
               	movq	%r8, 0x30(%rdi)
               	movq	0x20(%rbp), %rdi
               	movq	%rax, %r10
               	subq	%r10, %rax
               	addq	%rdi, %rax
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rcx, %rax
               	movq	%rdx, %rcx
               	subq	%rdx, %rcx
               	addq	%rax, %rcx
               	leaq	-0x118(%rbp), %rax
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x118(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rsi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rsi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rsi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rsi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rsi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	%rsi, %rax
               	addq	$0x140, %rsp            # imm = 0x140
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1f0, %rsp            # imm = 0x1F0
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rdx
               	leaq	0x7(%rdx), %rsi
               	addq	%rsi, %rcx
               	leaq	(%rax,%rax), %rsi
               	addq	%rax, %rsi
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
               	subq	%r10, %rdx
               	addq	%rcx, %rdx
               	leaq	(%rax,%rax,8), %rcx
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rdx, %rcx
               	incq	%rax
               	cmpq	$0x32, %rax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	(%rax,%rax,2), %rsi
               	addq	$0x7, %rsi
               	addq	%rsi, %rdx
               	incq	%rax
               	cmpq	$0x32, %rax
               	jl	<addr>
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	xorq	$0xfeed, %rdx           # imm = 0xFEED
               	movq	%rdx, (%rax)
               	movslq	%ecx, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x10(%rbp), %rax
               	cmpq	$0x12345520, %rax       # imm = 0x12345520
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	-0x170(%rbp), %rdi
               	movl	$0x7b, %esi
               	callq	<addr>
               	leaq	-0x170(%rbp), %rax
               	leaq	-0x90(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	%ebx, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x90(%rbp), %rdi
               	subq	$0x20, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x579e, %rax           # imm = 0x579E
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rbx, %rbx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x171, %rax            # imm = 0x171
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x1d0(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x1d0(%rbp), %rax
               	leaq	-0xf8(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	0x20(%rax), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	0x28(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	0x30(%rax), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	0x38(%rax), %rdx
               	movq	%rdx, 0x38(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movslq	%ebx, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0xf8(%rbp), %rdi
               	subq	$0x40, %rsp
               	movq	%rdi, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x65, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x1f0, %rsp            # imm = 0x1F0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x1f0, %rsp            # imm = 0x1F0
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
               	jmp	<addr>
               	addb	%al, (%rax)
