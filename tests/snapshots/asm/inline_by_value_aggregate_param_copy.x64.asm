
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
               	movb	$0x11, (%rax)
               	movzbq	(%rax), %rcx
               	movb	$-0x74, (%rax)
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
               	movb	$0x7, (%rax)
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movzbq	(%rax), %rcx
               	movb	$0x63, (%rax)
               	cmpl	$0x7, %ecx
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
               	movb	$0x8, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movb	$0x3, (%rax)
               	movzbq	(%rax), %rcx
               	movzbq	(%rax), %rdx
               	movb	$0x37, (%rax)
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
               	movb	$0x4, (%rax)
               	movb	$0x4d, (%rax)
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
