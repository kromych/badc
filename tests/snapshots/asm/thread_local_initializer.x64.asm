
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
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%fs:0x0, %rdx
               	addq	$-0x10, %rdx
               	movl	(%rdx), %edx
               	cmpl	$-0x3, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	%fs:0x0, %rsi
               	addq	$-0x8, %rsi
               	cmpl	$0x0, (%rsi)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
