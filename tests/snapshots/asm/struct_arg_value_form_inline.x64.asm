
struct_arg_value_form_inline.x64:	file format elf64-x86-64

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

<take_kuid>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	leave
               	retq

<take_triple>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movzbq	(%rax), %rdx
               	movzbq	0x1(%rax), %rcx
               	shlq	$0x8, %rcx
               	orq	%rdx, %rcx
               	movzbq	0x2(%rax), %rax
               	shlq	$0x10, %rax
               	orq	%rcx, %rax
               	leave
               	retq

<take_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	shlq	$0x20, %rcx
               	movl	(%rax), %eax
               	orq	%rcx, %rax
               	leave
               	retq

<take_wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rcx
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	retq
