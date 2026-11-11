
addr_null_compare_inline_param.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x5, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	addq	$0x5, %rax
               	movl	%eax, <rip> # <addr>
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpl	$0x6, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	leave
               	retq
