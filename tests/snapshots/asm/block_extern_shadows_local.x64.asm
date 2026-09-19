
block_extern_shadows_local.x64:	file format elf64-x86-64

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
               	addq	$0x0, %rcx
               	movl	$0x7, %edx
               	movl	%edx, (%rax)
               	addq	$0x5, %rcx
               	cmpl	$0x69, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x9, %rax
               	cmpl	$0x40, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	addq	$0x3, %rax
               	cmpl	$0x50, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
