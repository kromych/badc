
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
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x800(%rbp), %rdx
               	addq	%rcx, %rdx
               	movl	$0xaa, %esi
               	movb	%sil, (%rdx)
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x800, %ecx            # imm = 0x800
               	jb	<addr>
               	xorq	%rax, %rax
               	leave
               	retq

<or_bytes>:
               	movq	%rdx, %r8
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	%eax, %eax
               	leaq	(%rsi,%rdx), %r9
               	movzbq	(%r9), %r9
               	addq	%rdi, %r9
               	movzbq	(%r9), %r9
               	orq	%r9, %rax
               	leaq	0x1(%rdx), %rcx
               	movl	%ecx, %edx
               	movl	%r8d, %r9d
               	cmpl	%r9d, %edx
               	jb	<addr>
               	movl	%eax, %eax
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
               	movq	%rdi, %rax
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
               	movl	$0x1, %eax
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdi)
               	movb	%al, (%rdi)
               	movl	%eax, 0x4(%rdi)
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
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, 0x8(%rdi)
               	movl	$0x1, %eax
               	movb	%al, (%rdi)
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
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, 0x8(%rdi)
               	movl	$0x1, %eax
               	movw	%ax, 0xa(%rdi)
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
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, 0x8(%rdi)
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
               	movq	%rdi, %rax
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
               	xorq	%rax, %rax
               	movq	%rax, (%rdi)
               	movl	$0x1, %eax
               	movb	%al, (%rdi)
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
               	movl	$0x1, %eax
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdi)
               	movb	%al, (%rdi)
               	movl	%eax, 0x4(%rdi)
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
               	movl	$0x1, %eax
               	leaq	-0x8(%rbp), %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rdi)
               	movb	%al, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	callq	<addr>
               	movl	%ebx, %r12d
               	movl	$0x1, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%rax, %r12
               	callq	<addr>
               	movl	%r12d, %r12d
               	movq	%rbx, %rdi
               	callq	<addr>
               	orq	%r12, %rax
               	movl	%eax, %ebx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x3, %edx
               	callq	<addr>
               	orq	%rbx, %rax
               	movl	%eax, %ebx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x7, %edx
               	callq	<addr>
               	orq	%rbx, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
