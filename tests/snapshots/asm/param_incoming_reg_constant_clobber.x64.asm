
param_incoming_reg_constant_clobber.x64:	file format elf64-x86-64

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

<func_1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %esi
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edi
               	leaq	<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<func_10>:
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jg	<addr>
               	movl	(%rdx), %eax
               	movl	%eax, (%rdx)
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jle	<addr>
               	movzwq	<rip>, %rax # <addr>
               	retq

<func_17>:
               	leaq	<rip>, %rax # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %esi
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edi
               	leaq	<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
