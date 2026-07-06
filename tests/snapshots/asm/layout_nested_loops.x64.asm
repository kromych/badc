
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
               	xorq	%rdi, %rdi
               	jmp	<addr>
               	leaq	(%rcx,%rdi), %r8
               	movslq	%r8d, %r8
               	movl	$0x3, %r9d
               	pushq	%rax
               	pushq	%rdx
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r8
               	popq	%rdx
               	popq	%rax
               	testq	%r8, %r8
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x4, %rsi
               	jne	<addr>
               	jmp	<addr>
               	addq	%rdi, %rax
               	leaq	0x1(%rsi), %rdi
               	movslq	%edi, %rsi
               	cmpq	%rdx, %rsi
               	jl	<addr>
               	addq	%rcx, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x6, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
