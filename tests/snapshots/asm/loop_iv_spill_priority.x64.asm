
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	xorq	%rax, %rax
               	movl	(%rdi), %ecx
               	incq	%rcx
               	movl	%ecx, %r9d
               	movl	0x4(%rdi), %ecx
               	addq	$0x2, %rcx
               	movl	%ecx, %ebx
               	movl	0x8(%rdi), %ecx
               	addq	$0x3, %rcx
               	movl	%ecx, %r12d
               	movl	0xc(%rdi), %ecx
               	addq	$0x4, %rcx
               	movl	%ecx, %r13d
               	movl	0x10(%rdi), %ecx
               	addq	$0x5, %rcx
               	movl	%ecx, %r14d
               	movl	0x14(%rdi), %ecx
               	addq	$0x6, %rcx
               	movl	%ecx, %r15d
               	movl	0x18(%rdi), %ecx
               	addq	$0x7, %rcx
               	movl	%ecx, %r10d
               	movq	%r10, 0x38(%rsp)
               	movl	0x1c(%rdi), %ecx
               	addq	$0x8, %rcx
               	movl	%ecx, %r10d
               	movq	%r10, 0x30(%rsp)
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	%ecx, %esi
               	movl	%eax, %ecx
               	movq	%rcx, %rdx
               	andq	$0x7, %rdx
               	movl	(%rdi,%rdx,4), %edx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, %r8d
               	imulq	%r8, %rdx
               	movl	%edx, %edx
               	addq	%rsi, %rdx
               	movl	%edx, %edx
               	movq	%rdx, %rsi
               	shlq	%rsi
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %edx
               	cmpq	$0x3e8, %rdx            # imm = 0x3E8
               	jb	<addr>
               	movl	%ecx, %eax
               	movl	%r9d, %ecx
               	xorq	%rcx, %rax
               	movl	%ebx, %ecx
               	xorq	%rcx, %rax
               	movl	%r12d, %ecx
               	xorq	%rcx, %rax
               	movl	%r13d, %ecx
               	xorq	%rcx, %rax
               	movl	%r14d, %ecx
               	xorq	%rcx, %rax
               	movl	%r15d, %ecx
               	xorq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movq	0x30(%rsp), %rcx
               	movl	%ecx, %ecx
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x3e8, %esi            # imm = 0x3E8
               	callq	<addr>
               	movl	%eax, %eax
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
