
mem2reg_escape_point.x64:	file format elf64-x86-64

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

<bump>:
               	movslq	(%rdi), %rax
               	addq	$0x7, %rax
               	movl	%eax, (%rdi)
               	xorq	%rax, %rax
               	retq

<noise>:
               	leaq	(%rdi,%rdi,2), %rax
               	movslq	%eax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xa, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movl	$0xf, %ecx
               	movl	%ecx, (%rdi)
               	movslq	-0x10(%rbp), %rcx
               	subq	$0xa, %rcx
               	movslq	%ecx, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	%eax, -0x10(%rbp)
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	jmp	<addr>
               	movslq	-0x10(%rbp), %rsi
               	addq	%rsi, %rdx
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdi, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	jmp	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	movslq	%edx, %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	movslq	-0x8(%rbp), %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	movl	%edi, -0x18(%rbp)
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x18(%rbp), %rax
               	subq	$0xa, %rax
               	movslq	%eax, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
