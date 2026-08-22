
attribute_alias_target_later.x64:	file format elf64-x86-64

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

<probe_generic>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<after_alias>:
               	movl	$0x5, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %edi
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movslq	(%rbx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	movslq	(%rbx), %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rbx), %rax
               	addq	$0x4, %rax
               	movl	%eax, (%rbx)
               	movslq	%eax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
