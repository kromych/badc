
zero_length_array_decay.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpl	$0x5a, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	retq
