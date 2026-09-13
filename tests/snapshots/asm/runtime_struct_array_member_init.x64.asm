
runtime_struct_array_member_init.x64:	file format elf64-x86-64

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
               	leaq	0x8(%rax), %rcx
               	movslq	(%rax), %rdx
               	cmpl	$0xa, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rdx, %rdx
               	movq	%rdx, %rsi
               	cmpq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rdx, %rax
               	retq
