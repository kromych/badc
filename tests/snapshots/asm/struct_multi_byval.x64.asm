
struct_multi_byval.x64:	file format elf64-x86-64

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

<take_many>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	%rcx, -0x10(%rbp)
               	movq	%r8, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	leaq	<rip>, %rdx
               	leaq	-0x8(%rbp), %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rax
               	addq	%rcx, %rax
               	leaq	0x3e8(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leaq	-0x20(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	addq	%rax, %rcx
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	leaq	0x7d0(%rax), %rcx
               	leaq	-0x48(%rbp), %rax
               	movslq	(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0xc(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x10(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x14(%rax), %rax
               	addq	%rcx, %rax
               	movslq	0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, (%rdx)
               	xorq	%rax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0xb8(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	leaq	-0xa8(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%rdx)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%rdx)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%rdx)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	-0xb0(%rbp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movzbq	(%rax), %rdx
               	movb	%dl, (%rcx)
               	movzbq	0x1(%rax), %rdx
               	movb	%dl, 0x1(%rcx)
               	movzbq	0x2(%rax), %rdx
               	movb	%dl, 0x2(%rcx)
               	movzbq	0x3(%rax), %rdx
               	movb	%dl, 0x3(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x98(%rbp), %r8
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%r8)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%r8)
               	popq	%rcx
               	movq	%r8, %rax
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	popq	%rcx
               	movq	%rax, %rsi
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	movl	$0xbb8, %ebx            # imm = 0xBB8
               	subq	$0x30, %rsp
               	movq	%rbx, 0x28(%rsp)
               	movq	%r8, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	%rcx, %r8
               	movq	(%rdi), %rdi
               	movq	0x8(%rdx), %rcx
               	movq	(%rdx), %rdx
               	movq	(%r8), %r8
               	callq	<addr>
               	addq	$0x30, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1a12, %rax           # imm = 0x1A12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	leave
               	retq
