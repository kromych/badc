
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<add_one>:
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<advance>:
               	movq	%rdi, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	retq

<driver>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	$0x7, %rdx
               	jge	<addr>
               	jmp	<addr>
               	incq	%rcx
               	movslq	%ecx, %rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	imulq	$0x6, %rax, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
