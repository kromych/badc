
slot_coalesce_declared.x64:	file format elf64-x86-64

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
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
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
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rax), %rdx
               	addq	%rdx, %rcx
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
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
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
               	leaq	(%rax,%rbx), %rcx
               	leaq	0x1(%rcx), %rax
               	leaq	0x2(%rcx), %rdx
               	leaq	0x3(%rcx), %rsi
               	leaq	0x4(%rcx), %rdi
               	leaq	0x5(%rcx), %r8
               	leaq	0x6(%rcx), %r9
               	leaq	0x7(%rcx), %rbx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	leaq	(%rax,%rbx), %rdx
               	leaq	0x1(%rdx), %rax
               	leaq	0x2(%rdx), %rsi
               	leaq	0x3(%rdx), %rdi
               	leaq	0x4(%rdx), %r8
               	leaq	0x5(%rdx), %r9
               	leaq	0x6(%rdx), %rbx
               	leaq	0x7(%rdx), %r12
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	addq	%rbx, %rax
               	leaq	(%rax,%r12), %rdi
               	movq	0x10(%rbp), %r8
               	leaq	-0x40(%rbp), %rax
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	movq	%rsi, 0x20(%rax)
               	movq	%rsi, 0x28(%rax)
               	movq	%rsi, 0x30(%rax)
               	movq	%rsi, 0x38(%rax)
               	movq	0x20(%rbp), %rsi
               	movq	%rsi, (%rax)
               	movq	0x20(%rbp), %rsi
               	incq	%rsi
               	movq	%rsi, 0x8(%rax)
               	movq	0x20(%rbp), %rax
               	leaq	0x2(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rsi, 0x10(%rax)
               	movq	0x20(%rbp), %rsi
               	addq	$0x3, %rsi
               	movq	%rsi, 0x18(%rax)
               	movq	0x20(%rbp), %rsi
               	addq	$0x4, %rsi
               	movq	%rsi, 0x20(%rax)
               	movq	0x20(%rbp), %rax
               	leaq	0x5(%rax), %rsi
               	leaq	-0x40(%rbp), %rax
               	movq	%rsi, 0x28(%rax)
               	movq	0x20(%rbp), %rsi
               	addq	$0x6, %rsi
               	movq	%rsi, 0x30(%rax)
               	movq	0x20(%rbp), %rsi
               	movq	%rcx, %r10
               	subq	%r10, %rcx
               	addq	%rsi, %rcx
               	movq	%rdx, %r10
               	subq	%r10, %rdx
               	addq	%rdx, %rcx
               	movq	%rdi, %rdx
               	subq	%rdi, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x40(%rbp), %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%r8)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%r8)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%r8)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%r8)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%r8)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%r8)
               	popq	%rcx
               	movq	%r8, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%r8, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
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
               	movq	%rax, -0x48(%rbp)
               	leaq	-0x48(%rbp), %rax
               	movq	(%rax), %rdx
               	xorq	$0xfeed, %rdx           # imm = 0xFEED
               	movq	%rdx, (%rax)
               	movslq	%ecx, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x12345520, %rax       # imm = 0x12345520
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %edx
               	leaq	-0x60(%rbp), %rax
               	movl	$0x7b, %esi
               	movq	%rsi, (%rax)
               	movl	$0x552e, %esi           # imm = 0x552E
               	movq	%rsi, 0x8(%rax)
               	movl	$0x84, %esi
               	movq	%rsi, 0x10(%rax)
               	movl	$0x171, %esi            # imm = 0x171
               	movq	%rsi, 0x18(%rax)
               	leaq	-0xa0(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	je	<addr>
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
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rbx, %rbx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	-0xa0(%rbp), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x171, %rax            # imm = 0x171
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x40(%rbp), %rdi
               	movl	$0xa, %esi
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	-0x80(%rbp), %rdi
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movslq	%ebx, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
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
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
