
same_operand_algebra.x64:	file format elf64-x86-64

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

<xor_self>:
               	xorl	%eax, %eax
               	retq

<sub_self>:
               	xorl	%eax, %eax
               	retq

<and_self>:
               	movq	%rdi, %rax
               	retq

<or_self>:
               	movq	%rdi, %rax
               	retq

<or_all_ones>:
               	movq	$-0x1, %rax
               	retq

<or_all_ones_unsigned>:
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	retq

<or_all_ones_char>:
               	movl	$0xff, %eax
               	retq

<or_then_mask>:
               	movl	$0x30, %eax
               	retq

<or_then_wider_mask>:
               	movq	%rdi, %rax
               	orq	$0xf0, %rax
               	andq	$0x1f0, %rax            # imm = 0x1F0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x1234, -0x8(%rbp)     # imm = 0x1234
               	movl	-0x8(%rbp), %eax
               	orq	$0xf0, %rax
               	andq	$0x1f0, %rax            # imm = 0x1F0
               	cmpl	$0xf0, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
