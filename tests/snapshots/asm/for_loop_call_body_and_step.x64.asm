
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_one>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<advance>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<driver>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	incq	%rcx
               	movslq	%ecx, %rcx
               	incq	%rax
               	movslq	%eax, %rax
               	movslq	%eax, %rdx
               	cmpq	$0x7, %rdx
               	jl	<addr>
               	imulq	$0x6, %rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
