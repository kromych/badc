
mem2reg_cross_block.x64:	file format elf64-x86-64

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
               	addq	$0xe, %rax
               	incq	%rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
