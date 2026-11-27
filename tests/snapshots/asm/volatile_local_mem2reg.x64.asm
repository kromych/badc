
volatile_local_mem2reg.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	movl	$0x1, %eax
               	movl	%eax, 0x8(%rsp)
               	movl	$0x2, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movl	0x8(%rsp), %ecx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
