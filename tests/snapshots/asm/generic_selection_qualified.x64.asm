
generic_selection_qualified.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorl	%eax, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rsi, %rdx
               	sarq	$0x2, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x4(%rcx), %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, %rcx
               	sarq	$0x3f, %rcx
               	shrq	$0x3e, %rcx
               	addq	%rdx, %rcx
               	sarq	$0x2, %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, -0x20(%rbp)
               	leave
               	retq
