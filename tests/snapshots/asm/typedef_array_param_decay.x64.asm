
typedef_array_param_decay.x64:	file format elf64-x86-64

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

<copy>:
               	leaq	(%rdi), %rax
               	leaq	(%rsi), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%rsi), %rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%rsi), %rax
               	movq	%rax, 0x18(%rdi)
               	movq	0x20(%rsi), %rax
               	movq	%rax, 0x20(%rdi)
               	movq	0x28(%rsi), %rax
               	movq	%rax, 0x28(%rdi)
               	movq	0x30(%rsi), %rax
               	movq	%rax, 0x30(%rdi)
               	movq	0x38(%rsi), %rax
               	movq	%rax, 0x38(%rdi)
               	movq	0x40(%rsi), %rax
               	movq	%rax, 0x40(%rdi)
               	movq	0x48(%rsi), %rax
               	movq	%rax, 0x48(%rdi)
               	movq	0x50(%rsi), %rax
               	movq	%rax, 0x50(%rdi)
               	movq	0x58(%rsi), %rax
               	movq	%rax, 0x58(%rdi)
               	movq	0x60(%rsi), %rax
               	movq	%rax, 0x60(%rdi)
               	movq	0x68(%rsi), %rax
               	movq	%rax, 0x68(%rdi)
               	movq	0x70(%rsi), %rax
               	movq	%rax, 0x70(%rdi)
               	movq	0x78(%rsi), %rax
               	movq	%rax, 0x78(%rdi)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	leaq	-0x100(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x18(%rax)
               	movl	$0x5, %ecx
               	movq	%rcx, 0x20(%rax)
               	movl	$0x6, %ecx
               	movq	%rcx, 0x28(%rax)
               	movl	$0x7, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x100(%rbp), %rax
               	movl	$0x8, %ecx
               	movq	%rcx, 0x38(%rax)
               	movl	$0x9, %ecx
               	movq	%rcx, 0x40(%rax)
               	movl	$0xa, %ecx
               	movq	%rcx, 0x48(%rax)
               	movl	$0xb, %ecx
               	movq	%rcx, 0x50(%rax)
               	movl	$0xc, %ecx
               	movq	%rcx, 0x58(%rax)
               	movl	$0xd, %ecx
               	movq	%rcx, 0x60(%rax)
               	movl	$0xe, %ecx
               	movq	%rcx, 0x68(%rax)
               	leaq	-0x100(%rbp), %rsi
               	movl	$0xf, %eax
               	movq	%rax, 0x70(%rsi)
               	movl	$0x10, %eax
               	movq	%rax, 0x78(%rsi)
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	leaq	-0x80(%rbp), %rax
               	leaq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	addq	$0x0, %rcx
               	movq	0x8(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x10(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x18(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x20(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x28(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x30(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x38(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x40(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x48(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x50(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x58(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x60(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x68(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x70(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x78(%rax), %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x88, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	movq	0x78(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
