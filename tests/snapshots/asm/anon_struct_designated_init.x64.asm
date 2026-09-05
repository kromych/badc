
anon_struct_designated_init.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leave
               	retq
