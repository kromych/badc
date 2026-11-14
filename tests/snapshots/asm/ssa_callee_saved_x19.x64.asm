
ssa_callee_saved_x19.x64:	file format elf64-x86-64

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

<onExit>:
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x2, <rip> # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	-<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
