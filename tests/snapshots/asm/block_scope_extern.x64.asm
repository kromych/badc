
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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	0x4(%rax), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	movl	0x4(%rax), %esi
               	addq	%rsi, %rdx
               	movl	0x8(%rax), %eax
               	addq	%rdx, %rax
               	cmpl	$0x3c, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movl	$0x9, (%rcx)
               	xorl	%eax, %eax
               	retq
