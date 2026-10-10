
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
               	movq	(%rsi), %rax
               	movq	%rax, (%rdi)
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
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	$0x1, -0x100(%rbp)
               	movq	$0x2, -0xf8(%rbp)
               	movq	$0x3, -0xf0(%rbp)
               	movq	$0x4, -0xe8(%rbp)
               	movq	$0x5, -0xe0(%rbp)
               	movq	$0x6, -0xd8(%rbp)
               	movq	$0x7, -0xd0(%rbp)
               	movq	$0x8, -0xc8(%rbp)
               	movq	$0x9, -0xc0(%rbp)
               	movq	$0xa, -0xb8(%rbp)
               	movq	$0xb, -0xb0(%rbp)
               	movq	$0xc, -0xa8(%rbp)
               	movq	$0xd, -0xa0(%rbp)
               	movq	$0xe, -0x98(%rbp)
               	leaq	-0x100(%rbp), %rsi
               	movq	$0xf, -0x90(%rbp)
               	movq	$0x10, -0x88(%rbp)
               	leaq	-0x80(%rbp), %rdi
               	callq	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x70(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x68(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x60(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x50(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x40(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x38(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x28(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x20(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x10(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0x88, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x80(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
