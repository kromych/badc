
inline_two_word_struct_return.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x88, %rsp
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xa, %rax, %rdx
               	movl	%edx, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movslq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movslq	0x10(%rsp), %rcx
               	movq	0x18(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x20(%rsp), %rcx
               	movq	0x28(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x30(%rsp), %rcx
               	movq	0x38(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x40(%rsp), %rcx
               	movq	0x48(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x50(%rsp), %rcx
               	movq	0x58(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x60(%rsp), %rcx
               	movq	0x68(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	0x70(%rsp), %rcx
               	movq	0x78(%rsp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	addq	$0x16665, %rax          # imm = 0x16665
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	addq	$0x88, %rsp
               	retq
