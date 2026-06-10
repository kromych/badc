
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<add_one>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<advance>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	movslq	%ebx, %rax
               	cmpq	$0x7, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	movslq	%r12d, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	movslq	%r12d, %rax
               	imulq	$0x6, %rax, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
