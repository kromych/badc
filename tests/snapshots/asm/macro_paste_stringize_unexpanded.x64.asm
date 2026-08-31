
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
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x2, %esi
               	movl	%esi, (%rdx)
               	movslq	(%rax), %rax
               	addq	$0x2, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	retq
