
inline_by_value_aggregate_param_copy.x64:	file format elf64-x86-64

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

<via_param_write>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movl	$0x2a, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorq	%rcx, %rcx
               	movw	%cx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	$0x11, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rcx), %rcx
               	movzbq	(%rax), %rdx
               	addq	$0x5f4477, %rdx         # imm = 0x5F4477
               	shrq	$0x7, %rdx
               	addq	$0x3, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	andq	$0xff, %rax
               	andq	$0xff, %rax
               	xorq	$0x11, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x8c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rax
               	leaq	-0x10(%rbp), %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	$0x63, %edx
               	movb	%dl, (%rcx)
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x8, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rcx), %rcx
               	movzbq	(%rax), %rsi
               	movl	$0x37, %eax
               	movb	%al, (%rdx)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	imulq	$0xa, %rax, %rax
               	movq	%rsi, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x21, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x37, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x4, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movl	$0x4d, %edx
               	movb	%dl, (%rcx)
               	andq	$0xff, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
