
sxtw_fold_source_liveness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f>:
               	leaq	(%rdi,%rsi), %rcx
               	movslq	%edi, %rax
               	addq	%rcx, %rax
               	addq	%rsi, %rax
               	retq

<main>:
               	movl	$0x12, %eax
               	retq
