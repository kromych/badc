
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
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, %r8
               	sarq	$0x3f, %r8
               	shrq	$0x3e, %r8
               	addq	%r8, %rdx
               	sarq	$0x2, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x4(%rax), %rdx
               	movq	%rax, %r10
               	movq	%rdx, %rax
               	subq	%r10, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3e, %rdx
               	addq	%rdx, %rax
               	sarq	$0x2, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	%rcx, %rax
               	leave
               	retq
