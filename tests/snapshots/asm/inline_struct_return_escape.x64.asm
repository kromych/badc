
inline_struct_return_escape.x64:	file format elf64-x86-64

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

<mkesc>:
               	movl	$0x2a, %eax
               	movq	%rax, (%rsi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	$0x0, -0x8(%rbp)
               	movl	$0x2a, %edi
               	leaq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
