
unknown_size_struct_array_counts_what_its_fill_reaches.x64:	file format elf64-x86-64

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

<block_scope>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x30(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movw	$0x6261, -0x30(%rbp)    # imm = 0x6261
               	movb	$0x0, -0x2e(%rbp)
               	movl	$0x7, -0x2c(%rbp)
               	movw	$0x6564, -0x28(%rbp)    # imm = 0x6564
               	movb	$0x0, -0x26(%rbp)
               	movl	$0x2, -0x24(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x6261, -0x20(%rbp)    # imm = 0x6261
               	movb	$0x0, -0x1e(%rbp)
               	movl	$0x1, -0x1c(%rbp)
               	movw	$0x6564, -0x18(%rbp)    # imm = 0x6564
               	movb	$0x0, -0x16(%rbp)
               	movl	$0x7, -0x14(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rsi)
               	movw	$0x6261, -0x10(%rbp)    # imm = 0x6261
               	movb	$0x0, -0xe(%rbp)
               	movl	$0x7, -0xc(%rbp)
               	movw	$0x6564, -0x8(%rbp)     # imm = 0x6564
               	movb	$0x0, -0x6(%rbp)
               	movl	$0x2, -0x4(%rbp)
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x14, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	leaq	-0x20(%rbp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x1c(%rbp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xd, %eax
               	leave
               	retq
               	movl	$0xc, %eax
               	leave
               	retq
               	movl	$0xa, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movl	$0x7, %edi
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	leaq	0x18(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	cmpl	$0x0, 0x4(%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x14(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	<rip>, %rax # <addr>
               	leaq	0x10(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movl	0x4(%rax), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rcx
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	movq	%rcx, (%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rsp), %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x4(%rcx), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
