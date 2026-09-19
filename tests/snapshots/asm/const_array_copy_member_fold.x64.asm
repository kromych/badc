
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
               	movq	%rcx, %r12
               	movq	%rdx, %rbx
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movzbq	0x3(%rax), %rdi
               	movq	%rcx, %rax
               	xorq	%rbx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	%r12, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rsi, %rax
               	xorq	%r8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rdi, %rax
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
               	pushq	%r12
               	pushq	%rbx
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
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	testl	%esi, %esi
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	%r8, %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%eax, %eax
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
               	xorq	$0x3c, %rcx
               	xorl	%eax, %eax
               	testl	%ecx, %ecx
               	jne	<addr>
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
               	xorl	%esi, %esi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	movq	%rbx, %rdi
               	movq	%r12, %r9
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
