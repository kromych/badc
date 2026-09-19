
init_padding_zero.x64:	file format elf64-x86-64

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

<dirty>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x800, %rsp            # imm = 0x800
               	xorl	%eax, %eax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jae	<addr>
               	leaq	-0x800(%rbp), %rcx
               	addq	%rax, %rcx
               	movb	$-0x56, (%rcx)
               	incq	%rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	leave
               	retq

<or_bytes>:
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	cmpl	%edx, %eax
               	jae	<addr>
               	movzbq	(%rsi,%rax), %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %rcx
               	incq	%rax
               	cmpl	%edx, %eax
               	jb	<addr>
               	movq	%rcx, %rax
               	retq

<struct_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<struct_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, (%rdi)
               	movl	$0x1, 0x4(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<struct_runtime_partial>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movb	$0x1, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<struct_designated>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movw	$0x1, 0xa(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<struct_empty>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<union_const>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<union_runtime>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, (%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<compound_literal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, (%rdi)
               	movl	$0x1, 0x4(%rdi)
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<struct_by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, (%rdi)
               	movl	$0x1, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	orq	$0x0, %r12
               	callq	<addr>
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%r12, %rbx
               	orq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	orq	%rbx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
