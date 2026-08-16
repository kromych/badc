
struct_copy_comma_side_effect.x64:	file format elf64-x86-64

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

<via_global_scalar>:
               	movl	$0x9, %eax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rdx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rdx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rdx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rdx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rdx)
               	popq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	retq

<via_global_member>:
               	movl	$0x3, %ecx
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rdx), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rdx), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rdx), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rdx), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movq	%rax, %rdx
               	movb	%cl, (%rax)
               	movslq	0x4(%rax), %rax
               	retq

<via_deref>:
               	movl	$0x1, %eax
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movb	%al, (%rsi)
               	movsbq	%al, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	xorq	%rax, %rax
               	movl	%eax, 0x4(%rbx)
               	movl	$0x9, %edi
               	callq	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %r12
               	xorq	%rax, %rax
               	movl	%eax, 0x4(%r12)
               	movl	$0x3, %edi
               	callq	<addr>
               	movslq	0x4(%r12), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, 0x4(%rbx)
               	movl	$0x1, %edi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	0x4(%rbx), %rax
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
