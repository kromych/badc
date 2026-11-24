
wmem_functions.x64:	file format elf64-x86-64

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
               	subq	$0x38, %rsp
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movl	$0x1e, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	leaq	(%rsp), %rdi
               	leaq	0x8(%rdi), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	$0x63, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	(%rsp), %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x18(%rsp), %rdi
               	movl	$0x7, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	leaq	0x18(%rsp), %rsi
               	movl	0x18(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x1c(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	$0x28, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x4(%rsi), %rdi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	0x1c(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
