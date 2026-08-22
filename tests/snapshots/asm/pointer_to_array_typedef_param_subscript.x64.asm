
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

<set_row>:
               	movq	%rsi, %rcx
               	shlq	$0x6, %rcx
               	leaq	(%rdi,%rcx), %rax
               	leaq	(%rax), %r8
               	leaq	(%rdx), %r9
               	movq	%r9, (%r8)
               	leaq	0x1(%rdx), %r8
               	movq	%r8, 0x8(%rax)
               	leaq	0x2(%rdx), %r8
               	movq	%r8, 0x10(%rax)
               	leaq	(%rdi,%rcx), %rax
               	leaq	0x3(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	%rsi, %rcx
               	shlq	$0x6, %rcx
               	leaq	(%rdi,%rcx), %rax
               	leaq	0x4(%rdx), %r8
               	movq	%r8, 0x20(%rax)
               	leaq	0x5(%rdx), %r8
               	movq	%r8, 0x28(%rax)
               	leaq	0x6(%rdx), %r8
               	movq	%r8, 0x30(%rax)
               	leaq	(%rdi,%rcx), %rax
               	leaq	0x7(%rdx), %rcx
               	movq	%rcx, 0x38(%rax)
               	xorq	%rax, %rax
               	retq

<sum_row>:
               	movq	%rsi, %rcx
               	shlq	$0x6, %rcx
               	leaq	(%rdi,%rcx), %rax
               	leaq	(%rax), %rdx
               	movq	(%rdx), %rdx
               	addq	$0x0, %rdx
               	movq	0x8(%rax), %r8
               	addq	%r8, %rdx
               	movq	0x10(%rax), %r8
               	addq	%r8, %rdx
               	movq	0x18(%rax), %rax
               	addq	%rax, %rdx
               	movq	%rsi, %rcx
               	shlq	$0x6, %rcx
               	leaq	(%rdi,%rcx), %rax
               	movq	0x20(%rax), %r8
               	addq	%r8, %rdx
               	movq	0x28(%rax), %r8
               	addq	%r8, %rdx
               	movq	0x30(%rax), %r8
               	addq	%r8, %rdx
               	movq	0x38(%rax), %rax
               	addq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	leaq	-0x100(%rbp), %r12
               	movq	%r12, %rdi
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	$0x1, %esi
               	movl	$0x64, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	$0x2, %esi
               	leaq	-0x100(%rbp), %r12
               	movl	$0xc8, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	movl	$0x3, %esi
               	movl	$0x12c, %edx            # imm = 0x12C
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x65c, %rax            # imm = 0x65C
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x97c, %rax            # imm = 0x97C
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0xc0(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
