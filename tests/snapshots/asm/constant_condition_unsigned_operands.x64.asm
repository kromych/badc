
constant_condition_unsigned_operands.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	movl	$0xffffffff, -0x10(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, -0x8(%rbp) # imm = 0xFFFFFFFE
               	movl	-0x10(%rbp), %eax
               	movl	-0x8(%rbp), %ecx
               	cmpl	%ecx, %eax
               	setae	%al
               	movzbq	%al, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x10(%rbp), %ecx
               	movl	-0x8(%rbp), %esi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	cmpl	$0x1, %edx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
