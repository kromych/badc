
unroll_volatile_stays_rolled.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	incq	%rdx
               	movq	%rdx, (%rax)
               	incq	%rcx
               	cmpq	$0x4, %rcx
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x4, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rsi, %rsi
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x4, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	sete	%al
               	movzbq	%al, %rax
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
