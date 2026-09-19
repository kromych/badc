
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
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movzbq	0x8(%rax), %rcx
               	movb	%cl, 0x8(%rdx)
               	movzbq	0x9(%rax), %rcx
               	movb	%cl, 0x9(%rdx)
               	movzbq	0xa(%rax), %rcx
               	movb	%cl, 0xa(%rdx)
               	movzbq	0xb(%rax), %rcx
               	movb	%cl, 0xb(%rdx)
               	popq	%rcx
               	xorl	%eax, %eax
               	cmpl	$0xc, %eax
               	jge	<addr>
               	movsbq	(%rdx,%rax), %rsi
               	movsbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
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
