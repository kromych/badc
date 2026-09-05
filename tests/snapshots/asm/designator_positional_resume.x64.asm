
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
               	subq	$0x20, %rsp
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movzbq	0x8(%rcx), %rax
               	movb	%al, 0x8(%rsi)
               	movzbq	0x9(%rcx), %rax
               	movb	%al, 0x9(%rsi)
               	movzbq	0xa(%rcx), %rax
               	movb	%al, 0xa(%rsi)
               	movzbq	0xb(%rcx), %rax
               	movb	%al, 0xb(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movsbq	(%rdi), %rdi
               	leaq	(%rdx,%rcx), %r8
               	movsbq	(%r8), %r8
               	cmpl	%r8d, %edi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0xc, %eax
               	jl	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
