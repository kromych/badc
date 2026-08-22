
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

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
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rcx, %rdx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movl	$0xff, %edx
               	movb	%dl, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movzbq	(%rdx), %rsi
               	incq	%rsi
               	movb	%sil, (%rdx)
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	movslq	%edx, %rdx
               	cmpq	$0x1, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	testq	%rdx, %rdx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	orq	$0x0, %r12
               	movslq	%r12d, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
