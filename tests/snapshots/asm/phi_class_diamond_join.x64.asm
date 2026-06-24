
phi_class_diamond_join.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<test>:
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rsi, %rax
               	incq	%rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movq	%rdx, %rax
               	decq	%rax
               	movslq	%eax, %rcx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %edi
               	movl	$0xa, %esi
               	xorq	%rbx, %rbx
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %r12
               	movl	$0x14, %edx
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
