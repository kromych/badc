
empty_declaration.x64:	file format elf64-x86-64

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
               	movl	$0xb, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0xc, %esi
               	movl	%esi, (%rdx)
               	movslq	(%rax), %rax
               	addq	$0xc, %rax
               	cmpl	$0x17, %eax
               	je	<addr>
               	movq	%rcx, %rax
               	retq
               	xorq	%rax, %rax
               	retq
