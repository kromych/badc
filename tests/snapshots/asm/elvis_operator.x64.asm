
elvis_operator.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x0, (%rsp)
               	movl	$0x5, 0x8(%rsp)
               	movslq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x1, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	0x8(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	(%rsp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
               	movslq	0x8(%rsp), %rax
               	movl	$0x63, %ecx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rax
               	jmp	<addr>
               	movslq	(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x8(%rsp), %eax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	jmp	<addr>
