
float_literal_variadic_printf.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x48, %rsp
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	leaq	(%rsp), %rdi
               	movl	$0x40, %esi
               	movb	$0x2, %al
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x48, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x48, %rsp
               	retq
