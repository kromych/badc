
inline_nonleaf_const_switch.x64:	file format elf64-x86-64

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
               	subq	$0x28, %rsp
               	movl	$0x0, 0x18(%rsp)
               	movl	$0x3344, 0x10(%rsp)     # imm = 0x3344
               	movb	$0x44, 0x18(%rsp)
               	movl	0x10(%rsp), %eax
               	xorq	$0x3344, %rax           # imm = 0x3344
               	movl	0x18(%rsp), %ecx
               	xorq	$0x44, %rcx
               	orq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
