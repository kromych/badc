
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
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rdx,4), %r9
               	xorl	%eax, %eax
               	cmpl	%edx, %esi
               	jg	<addr>
               	movslq	%esi, %rcx
               	movslq	(%rdi,%rcx,4), %rcx
               	addq	%rcx, %rax
               	incq	%rsi
               	cmpl	%edx, %esi
               	jle	<addr>
               	addq	%r9, %rax
               	movslq	%eax, %rax
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
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rdx)
               	xorl	%ecx, %ecx
               	movq	%rax, %rdi
               	movq	%rcx, %rax
               	movslq	(%rdx,%rax,4), %rsi
               	addq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x4, %eax
               	jle	<addr>
               	leaq	(%rcx,%rdi), %rax
               	movslq	%eax, %rax
               	leave
               	retq
