
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
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdx, %rbx
               	movq	%rcx, %r12
               	movslq	%esi, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movzbq	0x3(%rax), %rax
               	xorq	%rbx, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdi
               	incq	%rdi
               	movl	%edi, (%rcx)
               	movq	%rdx, %rcx
               	xorq	%r12, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	movq	%rsi, %rcx
               	xorq	%r8, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	incq	%rdx
               	movl	%edx, (%rcx)
               	xorq	%r9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rbx
               	movl	$0x8, %eax
               	movb	%al, 0x7(%rbx)
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x3(%rax), %r8
               	movq	%rcx, %rax
               	xorq	$0x4, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%esi, %esi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rdi, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r8, %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x1, %r12d
               	movl	%r12d, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rdx, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x2(%rax), %rsi
               	movq	%rcx, %rax
               	xorq	$0x3c, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%rsi, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x3c, %eax
               	movl	$0x34, %ecx
               	movl	$0x2, %r9d
               	movq	%rdx, %rdi
               	movq	%r12, %r8
               	movq	%rax, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	xorq	%rsi, %rsi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
