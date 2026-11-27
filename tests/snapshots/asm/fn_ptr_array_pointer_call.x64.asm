
fn_ptr_array_pointer_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	leaq	<rip>, %rax # <addr>
               	imulq	$0xa, %rdi, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, <rip> # <addr>
               	retq

<g>:
               	imulq	$0xa, %rdi, %rax
               	addq	%rsi, %rax
               	retq

<main>:
               	subq	$0x18, %rsp
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	leaq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x3, %edi
               	movl	$0x4, %esi
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x22, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x5, %edi
               	movl	$0x6, %esi
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x7, %edi
               	movl	$0x8, %esi
               	callq	*%rax
               	movl	(%rax), %eax
               	cmpl	$0x4e, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	*%rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, 0x8(%rsp)
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	0x8(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rax
               	movq	(%rax), %rax
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x18, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1a, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	*%rax
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1d, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1e, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpl	$0x15, %eax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
