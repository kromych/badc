
sxtw_fold_source_liveness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	(%rdi,%rsi), %rcx
               	movslq	%edi, %rax
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	movl	$0x2, %eax
               	movl	$0x7, %ecx
               	movq	%rax, %rdx
               	shlq	$0x20, %rdx
               	addq	%rcx, %rax
               	sarq	$0x20, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
