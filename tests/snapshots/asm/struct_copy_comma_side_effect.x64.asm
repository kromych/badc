
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
               	leaq	<rip>, %rcx
               	movl	$0x0, 0x4(%rcx)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
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
               	movl	$0x9, (%rdi)
               	movslq	0x4(%rcx), %rdx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x0, 0x4(%rdx)
               	movl	$0x3, %eax
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
               	movb	%al, (%rdx)
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%edx, %edx
               	movl	%edx, 0x4(%rcx)
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%r8), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%r8), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%r8), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%r8), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	movb	$0x1, (%rsi)
               	movslq	0x4(%rcx), %rcx
               	cmpl	$0xf, %ecx
               	je	<addr>
               	retq
               	movq	%rdx, %rax
               	retq
