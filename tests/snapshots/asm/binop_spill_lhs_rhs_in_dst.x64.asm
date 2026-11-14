
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

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

<sum_at_high>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movl	(%rdi,%rdx,4), %r8d
               	xorl	%eax, %eax
               	cmpl	%edx, %esi
               	jg	<addr>
               	movl	(%rdi,%rsi,4), %ecx
               	addq	%rcx, %rax
               	incq	%rsi
               	cmpl	%edx, %esi
               	jle	<addr>
               	addq	%r8, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movabsq	$0x70000000c, %rax      # imm = 0x70000000C
               	movq	%rax, -0x18(%rbp)
               	movabsq	$0x50000000f, %rax      # imm = 0x50000000F
               	movq	%rax, -0x10(%rbp)
               	movl	$0xa, -0x8(%rbp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	movl	-0x18(%rbp,%rcx,4), %esi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	addq	$0xa, %rax
               	leave
               	retq
