
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movslq	%esi, %rsi
               	shlq	$0x2, %rsi
               	leaq	(%rdi,%rsi), %rax
               	movzbq	(%rax), %rsi
               	movzbq	0x1(%rax), %rdi
               	movzbq	0x2(%rax), %rbx
               	movzbq	0x3(%rax), %rax
               	xorq	%rsi, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	<rip>, %edx # <addr>
               	incq	%rdx
               	movl	%edx, <rip> # <addr>
               	xorq	%rdi, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movq	%rbx, %rcx
               	xorq	%r8, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	xorq	%r9, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rax # <addr>
               	movb	$0x8, <rip> # <addr>
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
               	xorq	$0x1, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movl	$0x1, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	<rip>, %rsi # <addr>
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
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	movl	$0x3c, %edx
               	movl	$0x34, %ecx
               	movl	$0x2, %r9d
               	movq	%rsi, %rdi
               	movq	%rax, %r8
               	movq	%rax, %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0x7, %edx
               	movl	$0x5, %ecx
               	movl	$0x1, %r9d
               	movq	%rsi, %r8
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	leave
               	retq
