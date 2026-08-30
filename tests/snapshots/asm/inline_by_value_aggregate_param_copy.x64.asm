
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
               	movl	$0x11, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movl	$0x8c, %edx
               	movb	%dl, (%rax)
               	andq	$0xff, %rcx
               	andq	$0xff, %rcx
               	andq	$0xff, %rcx
               	xorq	$0x11, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x8c, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movl	$0x63, %esi
               	movb	%sil, (%rdx)
               	andq	$0xff, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8, %ecx
               	movb	%cl, (%rax)
               	movq	%rax, %rdi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movzbq	(%rax), %rdx
               	movl	$0x37, %esi
               	movb	%sil, (%rax)
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	imulq	$0xa, %rax, %rax
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x21, %eax
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
               	leaq	<rip>, %rax
               	movl	$0x4d, %ecx
               	movb	%cl, (%rax)
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
