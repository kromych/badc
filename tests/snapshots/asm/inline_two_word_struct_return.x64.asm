
inline_two_word_struct_return.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	xorl	%eax, %eax
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rcx
               	imulq	$0xa, %rax, %rdx
               	movl	%edx, (%rcx)
               	movq	$0x1, 0x8(%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movslq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	addq	%rcx, %rax
               	movslq	-0x70(%rbp), %rcx
               	movq	-0x68(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x60(%rbp), %rcx
               	movq	-0x58(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x50(%rbp), %rcx
               	movq	-0x48(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x40(%rbp), %rcx
               	movq	-0x38(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x30(%rbp), %rcx
               	movq	-0x28(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x20(%rbp), %rcx
               	movq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	addq	%rcx, %rax
               	addq	$0x16665, %rax          # imm = 0x16665
               	xorl	%ecx, %ecx
               	movl	$0x1, %edx
               	cmpq	$0x16785, %rax          # imm = 0x16785
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	leave
               	retq
