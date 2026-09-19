
deferred_jit_thread_local.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx
               	movl	%eax, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movslq	(%rcx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movslq	(%rdx), %rsi
               	cmpl	$-0x3, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rcx), %rsi
               	movslq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	retq
