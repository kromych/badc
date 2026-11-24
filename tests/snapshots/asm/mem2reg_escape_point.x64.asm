
mem2reg_escape_point.x64:	file format elf64-x86-64

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

<bump>:
               	addl	$0x7, (%rdi)
               	retq

<noise>:
               	movl	$0x1e, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movl	$0xa, 0x8(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	jmp	<addr>
               	addl	$0x1, (%rcx)
               	incq	%rax
               	cmpl	$0x3, %eax
               	jge	<addr>
               	movl	0x8(%rsp), %esi
               	addq	%rsi, %rdx
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x8(%rsp), %rcx
               	jmp	<addr>
               	cmpl	$0x21, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xa, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	0x8(%rsp), %eax
               	subq	$0xa, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	subq	$0xa, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
