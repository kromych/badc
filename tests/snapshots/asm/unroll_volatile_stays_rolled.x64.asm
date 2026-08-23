
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
               	xorq	%rax, %rax
               	leaq	<rip>, %rcx
               	jmp	<addr>
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	incq	%rax
               	cmpq	$0x4, %rax
               	jl	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorq	%rcx, %rcx
               	testq	%rdx, %rdx
               	je	<addr>
               	cmpq	$0x4, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	retq
               	jmp	<addr>
