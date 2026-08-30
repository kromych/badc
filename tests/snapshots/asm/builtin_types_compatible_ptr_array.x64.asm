
builtin_types_compatible_ptr_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movl	$0x2a, %edx
               	movl	%edx, 0xc(%rax)
               	leaq	<rip>, %rax
               	leaq	0x10(%rax), %rcx
               	addq	$-0xc, %rcx
               	subq	$0x4, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
