
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
               	subq	$0x10, %rsp
               	movl	$0x7, -0x10(%rbp)
               	movl	$0x9, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	-0x8(%rbp), %rcx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0xb, (%rax)
               	movslq	-0x10(%rbp), %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
