
inline_asm_pushsection.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<probe>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %eax
               	movq	%rax, -0x10(%rbp)
               	nop
               	nop
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<fixup_style>:
               	nop
               	nop
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2a, %eax
               	movq	%rax, -0x10(%rbp)
               	nop
               	nop
               	nop
               	nop
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
