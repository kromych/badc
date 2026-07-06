
natural_width_local.x64:	file format elf64-x86-64

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
               	addq	$0x2c, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x4, %rdx
               	jl	<addr>
               	xorq	%rdx, %rdx
               	movslq	%ecx, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	leaq	0x8(%rdx), %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rax
               	retq
               	jmp	<addr>
               	movl	$0x1, %edx
               	jmp	<addr>
               	leaq	0x2(%rdx), %rax
               	movslq	%eax, %rdx
               	jmp	<addr>
               	leaq	0x4(%rdx), %rax
               	movslq	%eax, %rdx
               	jmp	<addr>
               	addb	%al, (%rax)
