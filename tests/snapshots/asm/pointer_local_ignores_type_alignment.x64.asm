
pointer_local_ignores_type_alignment.x64:	file format elf64-x86-64

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

<via_struct_pointer>:
               	movslq	(%rdi), %rax
               	movslq	0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<via_scalar_pointer>:
               	movslq	(%rdi), %rax
               	movslq	0xc(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
