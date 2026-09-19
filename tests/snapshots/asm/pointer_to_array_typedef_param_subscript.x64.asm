
pointer_to_array_typedef_param_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x100, %rsp            # imm = 0x100
               	leaq	-0x100(%rbp), %rcx
               	leaq	(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	$0x0, (%rdx)
               	movq	$0x1, 0x8(%rax)
               	movq	$0x2, 0x10(%rax)
               	movq	$0x3, 0x18(%rax)
               	movq	$0x4, 0x20(%rax)
               	movq	$0x5, 0x28(%rax)
               	movq	$0x6, 0x30(%rax)
               	movq	$0x7, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0x40(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	$0x64, (%rdx)
               	movq	$0x65, 0x8(%rax)
               	movq	$0x66, 0x10(%rax)
               	movq	$0x67, 0x18(%rax)
               	movq	$0x68, 0x20(%rax)
               	movq	$0x69, 0x28(%rax)
               	movq	$0x6a, 0x30(%rax)
               	movq	$0x6b, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0x80(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	$0xc8, (%rdx)
               	movq	$0xc9, 0x8(%rax)
               	movq	$0xca, 0x10(%rax)
               	movq	$0xcb, 0x18(%rax)
               	movq	$0xcc, 0x20(%rax)
               	movq	$0xcd, 0x28(%rax)
               	movq	$0xce, 0x30(%rax)
               	movq	$0xcf, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0xc0(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	$0x12c, (%rdx)          # imm = 0x12C
               	movq	$0x12d, 0x8(%rax)       # imm = 0x12D
               	movq	$0x12e, 0x10(%rax)      # imm = 0x12E
               	movq	$0x12f, 0x18(%rax)      # imm = 0x12F
               	movq	$0x130, 0x20(%rax)      # imm = 0x130
               	movq	$0x131, 0x28(%rax)      # imm = 0x131
               	movq	$0x132, 0x30(%rax)      # imm = 0x132
               	movq	$0x133, 0x38(%rax)      # imm = 0x133
               	leaq	-0x100(%rbp), %rcx
               	leaq	(%rcx), %rax
               	movq	0x8(%rax), %rdx
               	addq	$0x0, %rdx
               	movq	0x10(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x38(%rax), %rax
               	addq	%rdx, %rax
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rcx
               	leaq	0x80(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	(%rdx), %rdx
               	addq	$0x0, %rdx
               	movq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x38(%rax), %rax
               	addq	%rdx, %rax
               	cmpq	$0x65c, %rax            # imm = 0x65C
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rcx
               	leaq	0xc0(%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	(%rdx), %rdx
               	addq	$0x0, %rdx
               	movq	0x8(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x18(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x28(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x38(%rax), %rax
               	addq	%rdx, %rax
               	cmpq	$0x97c, %rax            # imm = 0x97C
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0xc0(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
