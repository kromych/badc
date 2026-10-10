
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
               	movb	$0x11, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rcx
               	movb	$-0x74, -0x8(%rbp)
               	xorq	$0x11, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rcx
               	xorq	$0x8c, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movb	$0x7, -0x8(%rbp)
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rax, (%rcx)
               	movzbq	-0x8(%rbp), %rcx
               	movb	$0x63, (%rax)
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x63, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movb	$0x8, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movb	$0x3, -0x8(%rbp)
               	movzbq	-0x8(%rbp), %rax
               	movb	$0x37, -0x8(%rbp)
               	imulq	$0xa, %rax, %rcx
               	addq	%rcx, %rax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movzbq	-0x8(%rbp), %rax
               	xorq	$0x37, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
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
