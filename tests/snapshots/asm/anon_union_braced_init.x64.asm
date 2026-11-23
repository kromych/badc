
anon_union_braced_init.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x68, %rsp
               	pushq	%rbx
               	movl	$0x7, -0x20(%rbp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, -0x18(%rbp)
               	movl	-0x20(%rbp), %ebx
               	movq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdi
               	movl	%ebx, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	movq	%rcx, 0x18(%rsp)
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	movl	(%rax), %edx
               	cmpl	%ebx, %edx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	-0x50(%rbp), %rdi
               	movq	$0x1, -0x50(%rbp)
               	movq	%rax, -0x48(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x63, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	-0x30(%rbp), %rdi
               	movq	$0x5, -0x30(%rbp)
               	movq	%rax, -0x28(%rbp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
