
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
               	movslq	(%rdi,%rdx,4), %r9
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%esi, %rcx
               	movslq	(%rdi,%rcx,4), %r8
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rcx), %rsi
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
               	movl	$0xc, %eax
               	movl	%eax, (%rdx)
               	movl	$0x7, %eax
               	movl	%eax, 0x4(%rdx)
               	movl	$0xf, %eax
               	movl	%eax, 0x8(%rdx)
               	movl	$0x5, %eax
               	movl	%eax, 0xc(%rdx)
               	movl	$0xa, %eax
               	movl	%eax, 0x10(%rdx)
               	xorq	%rax, %rax
               	movslq	0x10(%rdx), %r8
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	movslq	(%rdx,%rsi,4), %rdi
               	addq	%rdi, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rsi), %rcx
               	cmpl	$0x4, %ecx
               	jle	<addr>
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
