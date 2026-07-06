
branch_relaxation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movl	$0x3, %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	%rcx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movl	$0x3, %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	decq	%rax
               	jmp	<addr>
               	addq	$0x2, %rax
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
