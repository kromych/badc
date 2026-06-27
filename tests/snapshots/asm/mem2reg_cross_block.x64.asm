
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
               	subq	$0x20, %rsp
               	movl	$0xe, %eax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movslq	%edx, %rsi
               	cmpq	$0x3, %rsi
               	jge	<addr>
               	addq	%rax, %rcx
               	incq	%rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
