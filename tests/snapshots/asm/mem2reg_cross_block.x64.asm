
mem2reg_cross_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xe, %eax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movslq	%edx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	movslq	%ecx, %rcx
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	incq	%rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
