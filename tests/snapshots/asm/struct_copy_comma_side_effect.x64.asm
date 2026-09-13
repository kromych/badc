
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
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x9, %edx
               	leaq	<rip>, %rdi
               	leaq	<rip>, %r8
               	leaq	<rip>, %rsi
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%r8)
               	movzbq	0x8(%rsi), %rax
               	movb	%al, 0x8(%r8)
               	movzbq	0x9(%rsi), %rax
               	movb	%al, 0x9(%r8)
               	movzbq	0xa(%rsi), %rax
               	movb	%al, 0xa(%r8)
               	movzbq	0xb(%rsi), %rax
               	movb	%al, 0xb(%r8)
               	popq	%rax
               	movl	%edx, (%rdi)
               	movslq	0x4(%rax), %rdx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rdi
               	movl	%ecx, 0x4(%rdi)
               	movl	$0x3, %r8d
               	leaq	<rip>, %rdx
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
               	movb	%r8b, (%rdx)
               	movslq	0x4(%rdi), %rdx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	%ecx, 0x4(%rax)
               	leaq	<rip>, %rdx
               	movl	$0x1, %edi
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
               	movb	%dil, (%rdx)
               	movslq	0x4(%rax), %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movq	%r8, %rax
               	retq
               	movq	%rcx, %rax
               	retq
