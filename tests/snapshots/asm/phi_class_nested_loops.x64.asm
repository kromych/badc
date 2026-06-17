
phi_class_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<test>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %r8
               	cmpq	%rdi, %r8
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	movslq	%esi, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	movslq	%esi, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x7, %edi
               	movq	(%rsp), %r13
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	<addr>
