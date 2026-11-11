
builtin_return_address.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	0x8(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	cmpq	$0x0, <rip> # <addr>
               	cmoveq	%rcx, %rax
               	popq	%rbp
               	retq
