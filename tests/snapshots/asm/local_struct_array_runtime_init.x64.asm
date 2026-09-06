
local_struct_array_runtime_init.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x7, %eax
               	movl	%eax, -0x8(%rbp)
               	movl	$0x9, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rcx), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	(%rdx), %rax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xb, %eax
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
