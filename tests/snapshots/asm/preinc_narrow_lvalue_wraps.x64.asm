
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
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rdx
               	movq	%rax, %rdx
               	movq	%rax, %rdx
               	movq	%rcx, %rdx
               	movl	$0xff, %edx
               	movb	%dl, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movzbq	(%rdx), %rsi
               	incq	%rsi
               	movb	%sil, (%rdx)
               	movzbq	(%rdx), %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	-0x8(%rbp), %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
