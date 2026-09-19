
cacheline_aligned_member.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x44(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x44, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	0x40(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	jne	<addr>
               	leaq	0x80(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0x80, %ecx
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	0x40(%rax), %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	cmpl	$0x40, %ecx
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	leaq	0xc0(%rax), %rcx
               	subq	%rax, %rcx
               	cmpl	$0xc0, %ecx
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	leaq	<rip>, %rsi
               	movq	%rsi, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rsi
               	leaq	0x40(%rsi), %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movq	%rax, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	leaq	0x80(%rax), %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0xc0(%rax), %rdx
               	movq	%rdx, %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xb, (%rcx)
               	movl	$0x21, 0xc0(%rax)
               	movl	$0x2c, 0x40(%rsi)
               	leaq	<rip>, %rax
               	movl	$0x37, (%rax)
               	movslq	(%rcx), %rcx
               	cmpl	$0xb, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc0(%rcx), %rcx
               	cmpl	$0x21, %ecx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x40(%rcx), %rcx
               	cmpl	$0x2c, %ecx
               	jne	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x37, %eax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	xorl	%eax, %eax
               	retq
