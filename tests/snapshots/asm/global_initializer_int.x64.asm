
global_initializer_int.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x2a, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %edx
               	cmpl	$0x63, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	(%rax), %eax
               	movl	(%rcx), %ecx
               	addq	%rcx, %rax
               	retq
