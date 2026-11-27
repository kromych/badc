
inline_naked_not_inlined.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<identity_asm>:
               	movq	%rdi, %rax
               	retq

<use_identity>:
               	pushq	%rax
               	callq	<addr>
               	incq	%rax
               	popq	%r11
               	retq

<main>:
               	pushq	%rax
               	movl	$0x29, %edi
               	callq	<addr>
               	incq	%rax
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x2a, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%r11
               	retq
