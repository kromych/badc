
constant_condition_unsigned_operands.x64:	file format elf64-x86-64

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
               	movl	$0xffffffff, (%rsp)     # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, 0x8(%rsp)  # imm = 0xFFFFFFFE
               	movl	(%rsp), %eax
               	movl	0x8(%rsp), %ecx
               	cmpl	%ecx, %eax
               	setae	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	(%rsp), %ecx
               	movl	0x8(%rsp), %esi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
