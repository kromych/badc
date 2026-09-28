
loop_iv_spill_priority.x64:	file format elf64-x86-64

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

<hot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	movl	(%rdi), %ecx
               	leaq	0x1(%rcx), %r8
               	movl	0x4(%rdi), %ecx
               	leaq	0x2(%rcx), %r9
               	movl	0x8(%rdi), %ecx
               	leaq	0x3(%rcx), %rbx
               	movl	0xc(%rdi), %ecx
               	leaq	0x4(%rcx), %r12
               	movl	0x10(%rdi), %ecx
               	leaq	0x5(%rcx), %r13
               	movl	0x14(%rdi), %ecx
               	leaq	0x6(%rcx), %r14
               	movl	0x18(%rdi), %ecx
               	leaq	0x7(%rcx), %r15
               	movl	0x1c(%rdi), %ecx
               	leaq	0x8(%rcx), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rax, %rcx
               	movq	%rax, %rdx
               	andq	$0x7, %rdx
               	movl	(%rdi,%rdx,4), %edx
               	leaq	0x1(%rax), %rsi
               	imulq	%rsi, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	xorq	%rdx, %rcx
               	addq	%rax, %rcx
               	incq	%rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	jb	<addr>
               	movq	%rcx, %rax
               	xorq	%r8, %rax
               	xorq	%r9, %rax
               	xorq	%rbx, %rax
               	xorq	%r12, %rax
               	xorq	%r13, %rax
               	xorq	%r14, %rax
               	xorq	%r15, %rax
               	xorq	0x38(%rsp), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	andq	$0xff, %rax
               	leave
               	retq
