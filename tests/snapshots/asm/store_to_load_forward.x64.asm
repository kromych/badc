
store_to_load_forward.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	$0x15, (%rax)
               	movq	$0x5, -0x8(%rbp)
               	movq	$0x9, (%rax)
               	movq	$0x9, (%rax)
               	movq	%rcx, %rax
               	leave
               	retq
