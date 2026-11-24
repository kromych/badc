
clock_monotonic_advances.x64:	file format elf64-x86-64

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
               	leaq	0x8(%rsp), %rsi
               	movq	$-0x1, 0x8(%rsp)
               	movq	$-0x1, 0x10(%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x3, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x10(%rsp), %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x3b9aca00, %rax       # imm = 0x3B9ACA00
               	jl	<addr>
               	movl	$0x4, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	%eax, 0x28(%rsp)
               	movl	0x28(%rsp), %ecx
               	incq	%rcx
               	movl	%ecx, 0x28(%rsp)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0xf4240, %eax          # imm = 0xF4240
               	jl	<addr>
               	movl	$0x1, %edi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x38, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x6, %eax
               	addq	$0x38, %rsp
               	retq
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x10(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	movl	$0x7, %eax
               	addq	$0x38, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x38, %rsp
               	retq
