
dead_arm_static_callee.x64:	file format elf64-x86-64

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

<f>:
               	retq

<f2>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	$0xa, %rcx
               	movl	%ecx, (%rax)
               	retq

<main>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	$0xa, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0xa, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
