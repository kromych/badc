
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
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rsi,%rdx), %rdi
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%rsi)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%rsi)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%rsi)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%rsi)
               	popq	%rcx
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movslq	%eax, %rdx
               	movsbq	(%rsi,%rdx), %rdi
               	movsbq	(%rcx,%rdx), %rdx
               	cmpl	%edx, %edi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x6, %eax
               	leave
               	retq
               	movl	$0x2, %eax
               	leave
               	retq
