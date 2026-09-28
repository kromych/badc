
designator_scopes.x64:	file format elf64-x86-64

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

<scalar_forms>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x17, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0x10(%rcx), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x17, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x0, 0x10(%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x10(%rcx)
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movslq	0x8(%rcx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x5, %eax
               	leave
               	retq

<nested_struct_array>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	<rip>, %rax
               	movslq	0x28(%rax), %rcx
               	movslq	0x2c(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x28(%rcx), %rdx
               	movslq	0x2c(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rcx), %rcx
               	addq	%rdx, %rcx
               	cmpl	$0x12, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, 0x1c(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x14(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x1c(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0xd, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	cmpl	$0x0, 0x18(%rax)
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xe, %eax
               	leave
               	retq

<member_array_forms>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movslq	0xc(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movslq	0x4(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	movslq	0xc(%rcx), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x14, %eax
               	retq
               	movl	$0x13, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
