
control_flow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
