
fn_type_typedef_local.x64:	file format elf64-x86-64

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

<make>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdi, (%rax)
               	movq	%rdi, %rcx
               	shlq	%rcx
               	movslq	%ecx, %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	%rax, -0x28(%rbp)
               	movl	$0x4, %r13d
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	leaq	-0x20(%rbp), %rbx
               	movq	0x8(%rbx), %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x5, %edi
               	callq	*%rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rdx, -0x18(%rbp)
               	movq	(%rbx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movq	%r13, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%r12, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
