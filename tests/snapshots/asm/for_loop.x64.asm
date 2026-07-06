
for_loop.x64:	file format elf64-x86-64

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
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	incq	%rax
               	movslq	%eax, %rdx
               	cmpq	$0x5, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	retq
