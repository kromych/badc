
attributed_aggregate_align_floor.x64:	file format elf64-x86-64

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
               	subq	$0x80, %rsp
               	leaq	<rip>, %rdx
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movq	%rsi, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%rdi, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x7, %ecx
               	xorl	%r8d, %r8d
               	movq	%rcx, (%rax)
               	movq	%r8, 0x8(%rax)
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movq	(%rdx), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	(%rsi), %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	(%rdi), %rax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x31, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x35, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%r8, %rax
               	leave
               	retq
