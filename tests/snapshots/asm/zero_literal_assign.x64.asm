
zero_literal_assign.x64:	file format elf64-x86-64

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

<zero_pointer>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<zero_designated>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<zero_bytes>:
               	movw	$0x0, (%rdi)
               	movb	$0x0, 0x2(%rdi)
               	retq

<zero_mixed>:
               	movq	$0x0, (%rdi)
               	retq

<zero_tail>:
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movb	$0x0, 0xc(%rdi)
               	retq

<zero_union>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	retq

<zero_chained>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	retq

<zero_above_bound>:
               	xorps	%xmm14, %xmm14
               	movq	%rdi, %r10
               	leaq	0x250(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movq	$0x0, (%r10)
               	retq

<copy_nonzero>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leave
               	retq

<zero_local>:
               	xorq	%rax, %rax
               	retq

<main>:
               	xorq	%rax, %rax
               	retq
