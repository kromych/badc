
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
               	movslq	(%rdi,%rdx,4), %r8
               	xorl	%eax, %eax
               	cmpl	%edx, %esi
               	jg	<addr>
               	movslq	(%rdi,%rsi,4), %rcx
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
               	leaq	-0x18(%rbp), %rdx
               	movl	$0xc, (%rdx)
               	movl	$0x7, 0x4(%rdx)
               	movl	$0xf, 0x8(%rdx)
               	movl	$0x5, 0xc(%rdx)
               	movl	$0xa, %ecx
               	movl	%ecx, 0x10(%rdx)
               	xorl	%eax, %eax
               	movq	%rcx, %rdi
               	movq	%rax, %rcx
               	movslq	(%rdx,%rcx,4), %rsi
               	addq	%rsi, %rax
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	addq	%rdi, %rax
               	leave
               	retq
