
search_tables_trees_and_queues.x64:	file format elf64-x86-64

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

<cmp>:
               	movl	(%rdi), %eax
               	movl	(%rsi), %ecx
               	subq	%rcx, %rax
               	retq

<collect>:
               	cmpl	$0x1, %esi
               	je	<addr>
               	cmpl	$0x3, %esi
               	jne	<addr>
               	movslq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jge	<addr>
               	leaq	<rip>, %rcx # <addr>
               	leaq	0x1(%rax), %rdx
               	movl	%edx, <rip> # <addr>
               	movq	(%rdi), %rdx
               	movl	(%rdx), %edx
               	movl	%edx, (%rcx,%rax,4)
               	retq

<main>:
               	subq	$0xb8, %rsp
               	movq	$0x0, 0x18(%rsp)
               	movl	$0x1e, 0x20(%rsp)
               	movl	$0x28, 0x28(%rsp)
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	$0x3, 0x30(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x4(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0xc(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x14(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x20(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xb8, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x46, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xb8, %rsp
               	retq
               	movl	$0x0, <rip> # <addr>
               	movq	0x18(%rsp), %rdi
               	leaq	-<rip>, %rsi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0xc(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdi
               	leaq	0x18(%rsp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	callq	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	0x90(%rsp), %rsi
               	leaq	0x30(%rsp), %rdx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x28, %eax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x90(%rsp), %rsi
               	leaq	0x4(%rsi), %rdi
               	leaq	0x30(%rsp), %rdx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	callq	<addr>
               	leaq	0x90(%rsp), %rsi
               	leaq	0x4(%rsi), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x30(%rsp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	0x30(%rsp), %rdx
               	movl	$0x4, %ecx
               	leaq	-<rip>, %r8 # <addr>
               	callq	<addr>
               	leaq	0x90(%rsp), %rcx
               	addq	$0xc, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x48(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	0x60(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	0x78(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, (%rsp)
               	movl	$0x10, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	movq	0x8(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x40(%rsp)
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	movq	(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rax # <addr>
               	addq	$0x4, %rax
               	movq	%rax, 0x40(%rsp)
               	movl	$0x1, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xd, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	%rax, 0x38(%rsp)
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x8(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0xb8, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	%rax, 0x38(%rsp)
               	xorl	%edx, %edx
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xb8, %rsp
               	retq
               	callq	<addr>
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	movq	(%rsp), %rdi
               	callq	<addr>
               	leaq	0x48(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	0x78(%rsp), %rdi
               	leaq	0x48(%rsp), %rsi
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x48(%rsp), %rsi
               	callq	<addr>
               	leaq	0x48(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	leaq	0x60(%rsp), %rdi
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	0x60(%rsp), %rcx
               	leaq	0x78(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x80(%rsp), %rcx
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	0x68(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0xb8, %rsp
               	retq
               	callq	<addr>
               	leaq	0x48(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	leaq	0x78(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x80(%rsp), %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0xb8, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0xb8, %rsp
               	retq
