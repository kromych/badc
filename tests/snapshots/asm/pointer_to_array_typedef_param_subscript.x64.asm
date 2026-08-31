
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
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x100(%rbp), %rcx
               	leaq	(%rcx), %rax
               	leaq	(%rax), %rdx
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rdx)
               	movl	$0x1, %edx
               	movq	%rdx, 0x8(%rax)
               	movl	$0x2, %edx
               	movq	%rdx, 0x10(%rax)
               	movl	$0x3, %edx
               	movq	%rdx, 0x18(%rax)
               	movl	$0x4, %edx
               	movq	%rdx, 0x20(%rax)
               	movl	$0x5, %edx
               	movq	%rdx, 0x28(%rax)
               	movl	$0x6, %edx
               	movq	%rdx, 0x30(%rax)
               	movl	$0x7, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0x40(%rcx), %rax
               	leaq	(%rax), %rdx
               	movl	$0x64, %esi
               	movq	%rsi, (%rdx)
               	movl	$0x65, %edx
               	movq	%rdx, 0x8(%rax)
               	movl	$0x66, %edx
               	movq	%rdx, 0x10(%rax)
               	movl	$0x67, %edx
               	movq	%rdx, 0x18(%rax)
               	movl	$0x68, %edx
               	movq	%rdx, 0x20(%rax)
               	movl	$0x69, %edx
               	movq	%rdx, 0x28(%rax)
               	movl	$0x6a, %edx
               	movq	%rdx, 0x30(%rax)
               	movl	$0x6b, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0x80(%rcx), %rax
               	leaq	(%rax), %rdx
               	movl	$0xc8, %esi
               	movq	%rsi, (%rdx)
               	movl	$0xc9, %edx
               	movq	%rdx, 0x8(%rax)
               	movl	$0xca, %edx
               	movq	%rdx, 0x10(%rax)
               	movl	$0xcb, %edx
               	movq	%rdx, 0x18(%rax)
               	movl	$0xcc, %edx
               	movq	%rdx, 0x20(%rax)
               	movl	$0xcd, %edx
               	movq	%rdx, 0x28(%rax)
               	movl	$0xce, %edx
               	movq	%rdx, 0x30(%rax)
               	movl	$0xcf, %ecx
               	movq	%rcx, 0x38(%rax)
               	leaq	-0x100(%rbp), %rcx
               	leaq	0xc0(%rcx), %rax
               	leaq	(%rax), %rdx
               	movl	$0x12c, %esi            # imm = 0x12C
               	movq	%rsi, (%rdx)
               	movl	$0x12d, %edx            # imm = 0x12D
               	movq	%rdx, 0x8(%rax)
               	movl	$0x12e, %edx            # imm = 0x12E
               	movq	%rdx, 0x10(%rax)
               	movl	$0x12f, %edx            # imm = 0x12F
               	movq	%rdx, 0x18(%rax)
               	movl	$0x130, %edx            # imm = 0x130
               	movq	%rdx, 0x20(%rax)
               	movl	$0x131, %edx            # imm = 0x131
               	movq	%rdx, 0x28(%rax)
               	movl	$0x132, %edx            # imm = 0x132
               	movq	%rdx, 0x30(%rax)
               	movl	$0x133, %ecx            # imm = 0x133
               	movq	%rcx, 0x38(%rax)
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
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
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0xc0(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
