
loop_iv_spill_priority.x64:	file format elf64-x86-64

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

<hot>:
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movl	(%rdi), %eax
               	leaq	0x1(%rax), %r8
               	movl	0x4(%rdi), %eax
               	leaq	0x2(%rax), %r9
               	movl	0x8(%rdi), %eax
               	leaq	0x3(%rax), %rbx
               	movl	0xc(%rdi), %eax
               	leaq	0x4(%rax), %r12
               	movl	0x10(%rdi), %eax
               	leaq	0x5(%rax), %r13
               	movl	0x14(%rdi), %eax
               	leaq	0x6(%rax), %r14
               	movl	0x18(%rdi), %eax
               	leaq	0x7(%rax), %r15
               	movl	0x1c(%rdi), %eax
               	leaq	0x8(%rax), %rbp
               	movq	%rcx, %rax
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	movl	(%rdi,%rdx,4), %edx
               	leaq	0x1(%rcx), %rsi
               	imulq	%rsi, %rdx
               	addq	%rdx, %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	xorq	%rdx, %rax
               	addq	%rcx, %rax
               	incq	%rcx
               	cmpl	$0x3e8, %ecx            # imm = 0x3E8
               	jb	<addr>
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	%rbp, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq

<main>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	andq	$0xff, %rax
               	addq	$0x28, %rsp
               	retq
