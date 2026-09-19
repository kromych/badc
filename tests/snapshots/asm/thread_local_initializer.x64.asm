
thread_local_initializer.x64:	file format elf64-x86-64

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
               	movq	%fs:0x0, %rcx
               	addq	$-0x18, %rcx
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	movslq	(%rax), %rdx
               	cmpl	$-0x3, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	cmpl	$0x0, (%rdx)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rdx
               	movslq	(%rax), %rax
               	addq	%rdx, %rax
               	movl	%eax, (%rcx)
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
