
mem2reg_i64_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f>:
               	leaq	(%rdi,%rdi,2), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	addq	%rax, %rcx
               	incq	%rdx
               	cmpq	$0x4, %rdx
               	jl	<addr>
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
