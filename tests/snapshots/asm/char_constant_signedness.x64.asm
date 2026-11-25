
char_constant_signedness.x64:	file format elf64-x86-64

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

<pick>:
               	movsbq	(%rdi), %rax
               	cmpl	$-0x1, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	jl	<addr>
               	cmpl	$0x28, %eax
               	je	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$-0x80, %eax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0x80, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	movsbq	%cl, %rcx
               	cmpl	$-0x80, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xff, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	movsbq	%cl, %rcx
               	cmpl	$-0x1, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x80, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movb	%al, (%rsp)
               	movq	<rip>, %rax # <addr>
               	leaq	(%rsp), %rdi
               	callq	*%rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xff, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	movb	%al, (%rsp)
               	movq	<rip>, %rax # <addr>
               	leaq	(%rsp), %rdi
               	callq	*%rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
