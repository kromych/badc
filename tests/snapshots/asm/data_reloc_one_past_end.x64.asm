
data_reloc_one_past_end.x64:	file format elf64-x86-64

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
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movq	(%rax), %rsi
               	addq	%rsi, %rcx
               	addq	$0x8, %rax
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	%rcx, %rax
               	retq
