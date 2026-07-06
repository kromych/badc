
layout_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	leaq	(%rcx,%rsi), %rdx
               	movslq	%edx, %rdx
               	movl	$0x3, %edi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rdi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%esi, %rdx
               	cmpq	$0x4, %rdx
               	jne	<addr>
               	jmp	<addr>
               	addq	%rsi, %rax
               	movslq	%esi, %rdx
               	leaq	0x1(%rdx), %rsi
               	movslq	%esi, %rdx
               	movslq	%ecx, %rdi
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	addq	%rcx, %rax
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x6, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
