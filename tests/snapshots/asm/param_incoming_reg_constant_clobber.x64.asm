
param_incoming_reg_constant_clobber.x64:	file format elf64-x86-64

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

<func_1>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edi
               	movl	$0x5, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x5, %ecx
               	movl	$0x5, %r8d
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq

<func_10>:
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jg	<addr>
               	movslq	<rip>, %rax # <addr>
               	testq	%rax, %rax
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
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	movl	(%rax), %edi
               	movl	$0x5, %esi
               	leaq	<rip>, %rdx # <addr>
               	movl	$0x5, %ecx
               	movl	$0x5, %r8d
               	callq	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
