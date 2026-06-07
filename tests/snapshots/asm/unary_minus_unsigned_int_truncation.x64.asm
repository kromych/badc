
unary_minus_unsigned_int_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movl	$0x1, %edx
               	imulq	$-0x1, %rdx, %rax
               	movl	%eax, %eax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rdx, %rax
               	movl	%eax, %eax
               	orq	%rdx, %rax
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rdx, %rax
               	movl	%eax, %eax
               	orq	%rdx, %rax
               	shrq	$0x1f, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	imulq	$-0x1, %rcx, %rax
               	movl	%eax, %eax
               	orq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	imulq	$-0x1, %rdx, %rax
               	movl	%eax, %eax
               	movl	%eax, %ecx
               	orq	%rdx, %rcx
               	movl	$0xffffffff, %r13d      # imm = 0xFFFFFFFF
               	cmpq	%r13, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, %eax
               	orq	%rax, %rdx
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edx
               	xorq	%rax, %rax
               	xorq	%rax, %rdx
               	movl	%edx, %edx
               	imulq	$-0x1, %rdx, %rax
               	movl	%eax, %eax
               	orq	%rax, %rdx
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %ecx
               	xorq	%rcx, %rcx
               	movl	%ecx, %ecx
               	imulq	$-0x1, %rcx, %rax
               	movl	%eax, %eax
               	orq	%rax, %rcx
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
