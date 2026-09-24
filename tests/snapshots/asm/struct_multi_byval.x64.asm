
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
               	subq	$0x30, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	movq	%rdi, %rax
               	shrq	$0x20, %rax
               	movq	%rdx, %rsi
               	shrq	$0x20, %rsi
               	leaq	<rip>, %r9
               	addq	%rdi, %rax
               	addq	$0x3e8, %rax            # imm = 0x3E8
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rcx, %rax
               	leaq	(%rax,%r8), %rcx
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rax
               	addq	%rcx, %rax
               	leaq	0x7d0(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x14(%rax), %rax
               	addq	%rcx, %rax
               	movslq	0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, (%r9)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%rbx
               	leaq	-0x48(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	-0x38(%rbp), %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdx)
               	leaq	-0x40(%rbp), %r8
               	leaq	<rip>, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%r8)
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x10(%rsi), %r10
               	movq	%r10, 0x10(%rcx)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	movl	$0x7d0, %r9d            # imm = 0x7D0
               	movl	$0xbb8, %ebx            # imm = 0xBB8
               	subq	$0x30, %rsp
               	movq	%rbx, 0x28(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x20(%rsp)
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
