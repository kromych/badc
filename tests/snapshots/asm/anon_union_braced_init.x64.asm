
anon_union_braced_init.x64:	file format elf64-x86-64

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

<opaque>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x7, %eax
               	movl	%eax, -0x50(%rbp)
               	leaq	<rip>, %rbx
               	movq	%rbx, -0x48(%rbp)
               	movslq	-0x50(%rbp), %r12
               	movq	-0x48(%rbp), %r13
               	xorq	%rax, %rax
               	leaq	-0x10(%rbp), %rdi
               	movl	%r12d, %ecx
               	movl	%ecx, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	%r13, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	%r12d, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%r13, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %rdi
               	movl	%ecx, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	%rbx, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movl	$0x5, %ecx
               	leaq	-0x20(%rbp), %rdi
               	movl	%ecx, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	%rbx, 0x8(%rdi)
               	callq	<addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
