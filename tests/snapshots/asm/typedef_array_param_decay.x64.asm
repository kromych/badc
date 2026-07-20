
typedef_array_param_decay.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

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

<sum>:
               	leaq	(%rdi), %rax
               	movq	(%rax), %rax
               	addq	$0x0, %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x68(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rdi), %rcx
               	addq	%rcx, %rax
               	movq	0x78(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	leaq	-0x80(%rbp), %rax
               	addq	$0x0, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x2, %ecx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x4, %ecx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x5, %ecx
               	movq	%rcx, 0x20(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x6, %ecx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x30(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x8, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, 0x40(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xa, %ecx
               	movq	%rcx, 0x48(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xb, %ecx
               	movq	%rcx, 0x50(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xc, %ecx
               	movq	%rcx, 0x58(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xd, %ecx
               	movq	%rcx, 0x60(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xe, %ecx
               	movq	%rcx, 0x68(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0xf, %ecx
               	movq	%rcx, 0x70(%rax)
               	leaq	-0x80(%rbp), %rax
               	movl	$0x10, %ecx
               	movq	%rcx, 0x78(%rax)
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x88, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0x78(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
