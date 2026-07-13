
sizeof_function_call_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<harness>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movq	%rdi, %rcx
               	sarq	$0x8, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
