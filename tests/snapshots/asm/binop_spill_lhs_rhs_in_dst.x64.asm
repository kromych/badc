
binop_spill_lhs_rhs_in_dst.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_at_high>:
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	(%rdi,%rdx,4), %r9
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	(%rdi,%rcx,4), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rcx), %rsi
               	movslq	%esi, %rcx
               	cmpq	%rdx, %rcx
               	jle	<addr>
               	addq	%r9, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x18(%rbp), %rax
               	movl	$0xc, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xf, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rsi
               	xorq	%rax, %rax
               	movslq	0x10(%rsi), %r8
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	(%rsi,%rdx,4), %rdi
               	addq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x4, %rdx
               	jle	<addr>
               	leaq	(%rcx,%r8), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
