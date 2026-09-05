
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
               	movq	%rcx, %rbx
               	movslq	%esi, %rsi
               	movslq	%edx, %rdx
               	movslq	%ebx, %rbx
               	movslq	%r8d, %r8
               	movslq	%r9d, %r9
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rdi, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x3(%rax), %r12
               	movq	%rcx, %rax
               	andq	$0xff, %rax
               	xorq	%rdx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	%rbx, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	xorq	%r8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%r12, %rax
               	andq	$0xff, %rax
               	xorq	%r9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x1, %eax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	<rip>, %rax
               	movl	$0x8, %edx
               	movb	%dl, 0x7(%rax)
               	leaq	<rip>, %rax
               	addq	$0x4, %rax
               	movzbq	(%rax), %rdx
               	movzbq	0x1(%rax), %rsi
               	movzbq	0x2(%rax), %rdi
               	movzbq	0x3(%rax), %r8
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x4, %rax
               	movl	%eax, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rdx
               	andq	$0xff, %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rdi, %rdx
               	andq	$0xff, %rdx
               	xorq	$0x1, %rdx
               	movl	%edx, %edx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%r8, %rax
               	andq	$0xff, %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	$0x1, %ebx
               	movq	%rbx, %rax
               	movl	%ebx, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movzbq	(%rax), %rdx
               	movzbq	0x2(%rax), %rsi
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	xorq	$0x3c, %rax
               	movl	%eax, %edx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rsi, %rax
               	andq	$0xff, %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	$0x3c, %edx
               	movl	$0x34, %eax
               	movl	$0x2, %r9d
               	movq	%rcx, %rdi
               	movq	%rbx, %r8
               	movq	%rax, %rcx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	movq	%rsi, %r8
               	movq	%rbx, %r9
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
