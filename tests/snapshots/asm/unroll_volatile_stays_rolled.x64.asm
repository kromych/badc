
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
               	leaq	<rip>, %rcx
               	cmpl	$0x4, %eax
               	jge	<addr>
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpl	$0x4, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	sete	%al
               	movzbq	%al, %rax
               	retq
