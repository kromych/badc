
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
               	leaq	<rip>, %rcx      # <addr>
               	movl	%eax, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x10, %rcx
               	movl	(%rcx), %edx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x8, %rdx
               	movl	(%rdx), %esi
               	cmpl	$-0x3, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rcx), %esi
               	movl	(%rdx), %edx
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movq	%rdx, %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	retq
