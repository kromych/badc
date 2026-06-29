
syslimits_path_max.x64:	file format elf64-x86-64

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
               	subq	$0x1020, %rsp           # imm = 0x1020
               	xorq	%rdx, %rdx
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x1020, %rsp           # imm = 0x1020
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
