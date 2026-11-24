
struct_param_stack_spill.x64:	file format elf64-x86-64

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

<f16>:
               	subq	$0x18, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x38(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<f12>:
               	subq	$0x18, %rsp
               	movq	0x30(%rsp), %r10
               	movq	%r10, (%rsp)
               	movl	0x38(%rsp), %r10d
               	movl	%r10d, 0x8(%rsp)
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	addq	%r9, %rax
               	movq	0x20(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rsp), %rcx
               	addq	%rcx, %rax
               	movl	(%rsp), %ecx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movl	0x4(%rsp), %ecx
               	imulq	$0xa, %rcx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	$0x1, -0x10(%rbp)
               	movl	$0x2, %esi
               	movl	%esi, -0x8(%rbp)
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movq	-0x10(%rbp), %rdi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movq	<rip>, %rax # <addr>
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	callq	*%rax
               	addq	$0x20, %rsp
               	cmpq	$0xbe0, %rax            # imm = 0xBE0
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %eax
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movq	-0x10(%rbp), %rdi
               	movl	$0x2, %esi
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x8(%rsp)
               	movl	%eax, %eax
               	movabsq	$0x300000000, %r11      # imm = 0x300000000
               	orq	%r11, %rax
               	subq	$0x20, %rsp
               	movq	$0x7, (%rsp)
               	movq	$0x8, 0x8(%rsp)
               	movq	%rax, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
               	movq	0x28(%rsp), %r10
               	callq	*%r10
               	addq	$0x20, %rsp
               	cmpq	$0x10e, %rax            # imm = 0x10E
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
