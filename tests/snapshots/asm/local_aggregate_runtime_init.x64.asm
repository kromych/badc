
local_aggregate_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x38, %rsp
               	leaq	0x18(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, 0x10(%rax)
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	movl	%ecx, 0x18(%rsp)
               	movl	$0x616c6f68, 0x1c(%rsp) # imm = 0x616C6F68
               	leaq	0x18(%rsp), %rdi
               	movl	$0x0, 0x20(%rsp)
               	movw	$0x0, 0x24(%rsp)
               	movq	%rax, 0x28(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movsbq	0x4(%rax), %rcx
               	cmpl	$0x68, %ecx
               	jne	<addr>
               	movsbq	0x5(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	movsbq	0x6(%rax), %rcx
               	cmpl	$0x6c, %ecx
               	jne	<addr>
               	movsbq	0x7(%rax), %rcx
               	cmpl	$0x61, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	cmpb	$0x0, 0x8(%rax)
               	jne	<addr>
               	cmpb	$0x0, 0xd(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x10(%rax), %rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	movl	<rip>, %eax # <addr>
               	leaq	0x8(%rsp), %rdi
               	movl	%eax, 0x8(%rsp)
               	movl	<rip>, %eax # <addr>
               	movl	%eax, 0xc(%rsp)
               	movl	$0x5, 0x10(%rsp)
               	callq	<addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %ecx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x6f, %ecx
               	jne	<addr>
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x6b, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
