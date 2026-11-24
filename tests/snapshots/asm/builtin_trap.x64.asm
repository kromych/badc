
builtin_trap.x64:	file format elf64-x86-64

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
               	movl	$0x7, 0x8(%rsp)
               	movl	0x8(%rsp), %eax
               	testl	%eax, %eax
               	jl	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	movl	%eax, 0x8(%rsp)
               	movl	0x8(%rsp), %ecx
               	testl	%ecx, %ecx
               	jl	<addr>
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	addq	$0x18, %rsp
               	retq
               	ud2
               	ud2
