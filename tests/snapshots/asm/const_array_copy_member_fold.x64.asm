
const_array_copy_member_fold.x64:	file format elf64-x86-64

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

<check_field>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rsi
               	movzbq	0x1(%rax), %rdi
               	movzbq	0x2(%rax), %rbx
               	movzbq	0x3(%rax), %r12
               	movq	%rsi, %rax
               	xorq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rdi, %rax
               	xorq	%rcx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rbx, %rax
               	xorq	%r8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%r12, %rax
               	xorq	%r9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax
               	movb	$0x8, 0x7(%rax)
               	addq	$0x4, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movzbq	0x3(%rax), %rax
               	xorq	$0x4, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	%rsi, %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rsi
               	movslq	-0x8(%rbp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rsi, %rcx
               	movzbq	(%rcx), %rdx
               	movzbq	0x2(%rcx), %rcx
               	xorq	$0x3c, %rdx
               	testl	%edx, %edx
               	jne	<addr>
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movl	$0x3c, %edx
               	movl	$0x34, %ecx
               	movl	$0x2, %r9d
               	movq	%rsi, %rdi
               	movq	%rax, %r8
               	movq	%rax, %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	movl	$0x1, %r9d
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	leave
               	retq
