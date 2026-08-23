
nested_designator_init.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0xd, %eax
               	retq
               	movslq	0xc(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	xorq	%rax, %rax
               	retq
