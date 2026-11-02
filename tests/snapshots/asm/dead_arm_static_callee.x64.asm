
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
               	cmpl	$0xa, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
