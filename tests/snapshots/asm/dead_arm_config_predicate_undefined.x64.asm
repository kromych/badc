
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rax
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%eax, %eax
               	movq	%rsi, %rax
               	cmovneq	%rdx, %rax
               	addq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, -0x8(%rbp)
               	movl	$0x1, %ecx
               	movq	%rcx, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	andq	$0x8, %rdx
               	testl	%edx, %edx
               	cmovneq	%rcx, %rax
               	addq	$0xb, %rax
               	addq	$0xa, %rax
               	movq	$0x2, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0x3, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0x4, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0x5, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0x6, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0x7, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0x8, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0x9, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0xa, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0xb, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0xc, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0xd, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	movq	$0xe, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xa, %rcx
               	addq	%rcx, %rax
               	movq	$0xf, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	andq	$0x8, %rcx
               	movl	$0x1, %edx
               	xorl	%esi, %esi
               	testl	%ecx, %ecx
               	movq	%rsi, %rcx
               	cmovneq	%rdx, %rcx
               	addq	$0xb, %rcx
               	addq	%rcx, %rax
               	cmpl	$0xb0, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	xorl	%eax, %eax
               	leave
               	retq
