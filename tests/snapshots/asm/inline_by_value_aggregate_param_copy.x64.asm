
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movw	$0x0, (%rax)
               	movl	$0x11, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movl	$0x8c, %edx
               	movb	%dl, (%rax)
               	xorq	$0x11, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	(%rax), %rcx
               	xorq	$0x8c, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7, %ecx
               	movb	%cl, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movzbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movl	$0x63, %edx
               	movb	%dl, (%rcx)
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rcx
               	xorq	$0x63, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x8, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x3, %ecx
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movzbq	(%rax), %rdx
               	movl	$0x37, %esi
               	movb	%sil, (%rax)
               	imulq	$0xa, %rcx, %rax
               	addq	%rdx, %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x37, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
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
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
