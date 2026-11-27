
memcpy_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movl	$0x41414141, (%rbx)     # imm = 0x41414141
               	movl	(%rbx), %r10d
               	movl	%r10d, (%rax)
               	movsbq	(%rax), %rax
               	popq	%rbx
               	retq
