
fn_ptr_array_pointer_call.x64:	file format elf64-x86-64

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

<sel>:
               	leaq	<rip>, %rax
               	imulq	$0xa, %rdi, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rax)
               	retq

<g>:
               	imulq	$0xa, %rdi, %rax
               	addq	%rsi, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x10(%rax), %rax
               	movl	$0x5, %edi
               	movl	$0x6, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x7, %edi
               	movl	$0x8, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x4e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	*%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x18(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x28(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
