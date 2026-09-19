
block_scope_extern.x64:	file format elf64-x86-64

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
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	movslq	0x4(%rax), %rsi
               	addq	%rsi, %rcx
               	movslq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x3c, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x9, (%rdx)
               	xorl	%eax, %eax
               	retq
