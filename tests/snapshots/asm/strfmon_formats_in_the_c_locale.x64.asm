
strfmon_formats_in_the_c_locale.x64:	file format elf64-x86-64

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
               	subq	$0x68, %rsp
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	movsd	<rip>, %xmm1
               	movsd	<rip>, %xmm2
               	movsd	<rip>, %xmm3
               	leaq	(%rsp), %rdi
               	movl	$0x60, %esi
               	movb	$0x4, %al
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x68, %rsp
               	retq
               	leaq	<rip>, %rdx
               	movsd	<rip>, %xmm0
               	leaq	(%rsp), %rdi
               	movl	$0x4, %esi
               	movb	$0x1, %al
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x68, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x68, %rsp
               	retq
