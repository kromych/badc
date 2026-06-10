
mem2reg_i64_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	(%rdi,%rdi,2), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	cmpq	$0x4, %rdx
               	jge	<addr>
               	addq	%rax, %rcx
               	incq	%rdx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
