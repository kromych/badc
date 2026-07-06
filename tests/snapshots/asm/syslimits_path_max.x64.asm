
syslimits_path_max.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	xorq	%rdx, %rdx
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %edx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
