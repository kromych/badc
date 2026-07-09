
shift_result_type_signedness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sext>:
               	movslq	%esi, %rsi
               	movl	%edi, %eax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	shlq	%cl, %rax
               	popq	%rcx
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	pushq	%rcx
               	movq	%rsi, %rcx
               	sarq	%cl, %rax
               	popq	%rcx
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
