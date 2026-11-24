
init_padding_zero.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x808, %rsp            # imm = 0x808
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	addq	%rax, %rcx
               	movb	$-0x56, (%rcx)
               	incq	%rax
               	cmpl	$0x800, %eax            # imm = 0x800
               	jb	<addr>
               	addq	$0x808, %rsp            # imm = 0x808
               	retq

<or_bytes>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	%edx, %ecx
               	jae	<addr>
               	movzbq	(%rsi,%rcx), %r8
               	addq	%rdi, %r8
               	movzbq	(%r8), %r8
               	orq	%r8, %rax
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jb	<addr>
               	retq

<struct_const>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<struct_runtime>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, 0x8(%rsp)
               	movl	$0x1, 0xc(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<struct_runtime_partial>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movb	$0x1, (%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<struct_designated>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	movw	$0x1, 0xa(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<struct_empty>:
               	subq	$0x18, %rsp
               	leaq	(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x4, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<union_const>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x7, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<union_runtime>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, 0x8(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x7, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<compound_literal>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, 0x8(%rsp)
               	movl	$0x1, 0xc(%rsp)
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<by_value>:
               	subq	$0x18, %rsp
               	movq	%rdi, 0x8(%rsp)
               	leaq	0x8(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<struct_by_value>:
               	subq	$0x18, %rsp
               	leaq	0x8(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movb	$0x1, 0x8(%rsp)
               	movl	$0x1, 0xc(%rsp)
               	movq	(%rdi), %rdi
               	callq	<addr>
               	addq	$0x18, %rsp
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	callq	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x3, %edx
               	callq	<addr>
               	orq	%rax, %rbx
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x7, %edx
               	callq	<addr>
               	orq	%rbx, %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
