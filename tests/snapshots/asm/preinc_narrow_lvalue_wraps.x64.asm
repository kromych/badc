
preinc_narrow_lvalue_wraps.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0x1, %eax
               	movl	$0x1, %eax
               	xorq	%rax, %rax
               	movl	$0xff, %eax
               	movb	%al, -0xc0(%rbp)
               	leaq	-0xc0(%rbp), %rax
               	xorq	%rcx, %rcx
               	movzbq	(%rax), %rdx
               	incq	%rdx
               	movb	%dl, (%rax)
               	movzbq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %ecx
               	movslq	%ecx, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzbq	-0xc0(%rbp), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	orq	$0x0, %rbx
               	movslq	%ebx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
