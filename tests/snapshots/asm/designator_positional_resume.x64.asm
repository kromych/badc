
designator_positional_resume.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movsbq	(%rdi), %rdi
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rsi)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rsi)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rsi)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rsi)
               	popq	%rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movsbq	(%rdi), %rdi
               	addq	%rcx, %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
