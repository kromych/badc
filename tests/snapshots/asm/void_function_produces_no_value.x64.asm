
void_function_produces_no_value.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<no_value_void>:
               	xorq	%rax, %rax
               	retq

<early_return_void>:
               	testl	%edi, %edi
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	xorq	%rax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	retq
