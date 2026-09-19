
local_array_runtime_nested_init.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x5, -0x20(%rbp)
               	movl	$0x6, -0x18(%rbp)
               	movl	$0x7, -0x10(%rbp)
               	movl	$0x8, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movslq	(%rcx), %rax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	movslq	(%rdx), %rax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movslq	(%rsi), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
