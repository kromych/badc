
addr_of_array_lvalue.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x48, %rsp
               	leaq	0x10(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0xc, %rax
               	movq	%rax, 0x38(%rsp)
               	movl	$0x2a, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	0x18(%rsp), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	movl	0x14(%rsp), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	0x30(%rsp), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	0x38(%rsp), %rax
               	movl	0x10(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	0xc(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x48, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	0x5c(%rax), %ecx
               	cmpl	$0x2a, %ecx
               	jne	<addr>
               	movl	0x2c(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3d, %rcx
               	addq	%rax, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x48, %rsp
               	retq
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rcx)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rcx)
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x6, %ecx
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x4, %ecx
               	jne	<addr>
               	addq	$0xf, %rax
               	andq	$-0x10, %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x8(%rcx), %rax
               	subq	%rcx, %rax
               	movq	%rax, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rcx, %rax
               	sarq	$0x2, %rax
               	addq	$0x3, %rax
               	andq	$-0x4, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x17, %eax
               	xorl	%ecx, %ecx
               	movl	<rip>, %edx # <addr>
               	cmpl	$0x2a, %edx
               	cmoveq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x1b, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x13, %eax
               	addq	$0x48, %rsp
               	retq
               	movl	$0x6, %eax
               	addq	$0x48, %rsp
               	retq
