
const_struct_array_inline_accessor.x64:	file format elf64-x86-64

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

<main>:
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	xorq	%rcx, %rcx
               	movq	%rax, %rcx
               	leaq	<rip>, %rcx
               	addq	$0x8, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	leaq	<rip>, %rax
               	addq	$0x8, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	retq
