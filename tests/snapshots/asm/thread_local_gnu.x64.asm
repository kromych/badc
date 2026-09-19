
thread_local_gnu.x64:	file format elf64-x86-64

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
               	movq	%fs:0x0, %rax
               	addq	$-0x10, %rax
               	cmpl	$0x0, (%rax)
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x7, (%rax)
               	movl	$0x2a, (%rcx)
               	movslq	(%rax), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	(%rcx), %rdx
               	cmpl	$0x2a, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	(%rax), %rdx
               	movslq	(%rcx), %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x31, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
