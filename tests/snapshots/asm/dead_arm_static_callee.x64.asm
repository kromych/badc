
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
               	movl	<rip>, %eax # <addr>
               	addq	$0xa, %rax
               	movl	%eax, <rip> # <addr>
               	retq

<main>:
               	movl	<rip>, %eax # <addr>
               	addq	$0xa, %rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0xa, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	retq
