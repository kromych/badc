
generic_selection_qualified.x64:	file format elf64-x86-64

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
               	movl	$0x2, %eax
               	retq

<pickc>:
               	movl	$0x1, %eax
               	retq

<pickw>:
               	movl	$0x2, %eax
               	retq

<main>:
               	subq	$0x18, %rsp
               	xorl	%eax, %eax
               	movl	%eax, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdx
               	leaq	0x4(%rdx), %rcx
               	subq	%rdx, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq
