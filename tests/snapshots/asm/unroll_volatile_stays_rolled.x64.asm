
unroll_volatile_stays_rolled.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	incq	%rcx
               	movq	%rcx, <rip> # <addr>
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	movq	<rip>, %rcx # <addr>
               	xorl	%edx, %edx
               	cmpl	$0x4, %eax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x4, %rcx
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	retq
