
struct_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x4, %edx
               	movl	%edx, 0x4(%rax)
               	movslq	%ecx, %rsi
               	movslq	%ecx, %rcx
               	imulq	%rsi, %rcx
               	movslq	%edx, %rax
               	movslq	%edx, %rdx
               	imulq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
