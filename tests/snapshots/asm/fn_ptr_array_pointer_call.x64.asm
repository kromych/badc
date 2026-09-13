
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
               	leaq	<rip>, %rcx
               	imulq	$0xa, %rdi, %rax
               	addq	%rsi, %rax
               	movl	%eax, (%rcx)
               	movq	%rcx, %rax
               	retq

<g>:
               	imulq	$0xa, %rdi, %rax
               	addq	%rsi, %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	leaq	<rip>, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x10(%rbx), %rax
               	movl	$0x5, %edi
               	movl	$0x6, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%rbx), %rax
               	movl	$0x7, %edi
               	movl	$0x8, %esi
               	callq	*%rax
               	movslq	(%rax), %rax
               	cmpl	$0x4e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	*%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movq	%rbx, -0x8(%rbp)
               	leaq	<rip>, %r12
               	leaq	-0x8(%rbp), %r13
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%r13), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%r13), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	(%r13), %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x28(%r12), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x28(%r12), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x18(%r12), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
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
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	leaq	<rip>, %rbx
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movq	0x8(%rbx), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
