
thread_local_object_alignment.x64:	file format elf64-x86-64

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

<block_scope_boundaries>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%fs:0x0, %rax
               	addq	$-0x98, %rax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x80, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x68, %rcx
               	andq	$0x7, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, (%rax,%riz)
               	movq	%fs:0x0, %rcx
               	addq	$-0x80, %rcx
               	movl	$0x3, %esi
               	movq	%rsi, (%rcx)
               	movl	$0x4, %edi
               	movq	%rdi, 0x8(%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x68, %rcx
               	movl	$0x5, %r8d
               	movq	%r8, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x50, %rcx
               	movl	$0x6, %r9d
               	movq	%r9, (%rcx)
               	movl	$0x7, %ebx
               	movq	%rbx, 0x8(%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0xa0, %rcx
               	movl	$0x1, %ebx
               	movb	%bl, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x90, %rcx
               	movl	$0x2, %ebx
               	movb	%bl, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x70, %rcx
               	movb	%sil, (%rcx)
               	movq	%fs:0x0, %rcx
               	addq	$-0x60, %rcx
               	movb	%dil, (%rcx)
               	movsd	(%rax,%riz), %xmm0
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%fs:0x0, %rax
               	addq	$-0x68, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%r8, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0x80, %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rax, %rcx
               	movq	%fs:0x0, %rax
               	addq	$-0x50, %rax
               	movq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%r9, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	addq	$-0xa0, %rax
               	movsbq	(%rax), %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x90, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x70, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	%fs:0x0, %rcx
               	addq	$-0x60, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<wide_array_boundary>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x30, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	leaq	0x10(%rax), %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	movl	$0x8, %ecx
               	movq	%rcx, 0x20(%rax)
               	movq	%fs:0x0, %rcx
               	addq	$-0x40, %rcx
               	movl	$0x1, %edx
               	movb	%dl, (%rcx)
               	movq	0x20(%rax), %rax
               	incq	%rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
