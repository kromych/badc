
mem2reg_i64_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<f>:
               	leaq	(%rdi,%rdi,2), %rax
               	leaq	(%rax), %rcx
               	addq	%rax, %rcx
               	addq	%rax, %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	movl	$0x54, %eax
               	retq
               	addb	%al, 0x41(%rdx)
