
pointer_to_array_typedef_param_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<set_row>:
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	addq	$0x0, %rax
               	leaq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x1(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x2(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x3(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x4(%rdx), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x5(%rdx), %rcx
               	movq	%rcx, 0x28(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x6(%rdx), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	leaq	0x7(%rdx), %rcx
               	movq	%rcx, 0x38(%rax)
               	xorq	%rax, %rax
               	retq

<sum_row>:
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	addq	$0x0, %rax
               	movq	(%rax), %rax
               	leaq	(%rax), %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x10(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x18(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x20(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x28(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x30(%rax), %rax
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	shlq	$0x6, %rax
               	addq	%rdi, %rax
               	movq	0x38(%rax), %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	xorq	%rsi, %rsi
               	leaq	-0x100(%rbp), %rdi
               	xorq	%rdx, %rdx
               	callq	<addr>
               	movl	$0x1, %esi
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x64, %edx
               	callq	<addr>
               	movl	$0x2, %esi
               	leaq	-0x100(%rbp), %rdi
               	movl	$0xc8, %edx
               	callq	<addr>
               	movl	$0x3, %esi
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x12c, %edx            # imm = 0x12C
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorq	%rsi, %rsi
               	callq	<addr>
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x65c, %rax            # imm = 0x65C
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	cmpq	$0x97c, %rax            # imm = 0x97C
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	leaq	-0x100(%rbp), %rax
               	movq	0xc0(%rax), %rax
               	cmpq	$0x12c, %rax            # imm = 0x12C
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x120, %rsp            # imm = 0x120
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
