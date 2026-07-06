
phi_class_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<test>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	jmp	<addr>
               	incq	%rsi
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	incq	%rdx
               	movslq	%edx, %r8
               	cmpq	%rdi, %r8
               	jl	<addr>
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
