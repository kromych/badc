
macro_paste_stringize_unexpanded.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x2, (%rdx)
               	movslq	(%rcx), %rcx
               	addq	$0x2, %rcx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	retq
               	xorl	%eax, %eax
               	retq
