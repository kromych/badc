
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

<main>:
               	leaq	<rip>, %rax
               	movl	$0x0, 0x4(%rax)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rsi), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rsi), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rsi), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rsi), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movl	$0x9, (%rdi)
               	movslq	0x4(%rax), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x0, 0x4(%rcx)
               	movl	$0x3, %edx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movb	%dl, (%rcx)
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rax
               	leaq	<rip>, %r8
               	pushq	%rcx
               	movq	(%r8), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%r8), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%r8), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%r8), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%r8), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	movb	$0x1, (%rsi)
               	movslq	0x4(%rax), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movq	%rdx, %rax
               	retq
               	movq	%rcx, %rax
               	retq
