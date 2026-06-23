
flex_array_member_static_init.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movq	%r13, (%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	popq	%rax
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x8, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	movq	%rax, %rcx
               	addq	$0x18, %rcx
               	movslq	%edx, %rsi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	leaq	-0x8(%rbp), %rsi
               	movslq	%edx, %rdi
               	addq	%rdi, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	xorq	%rdx, %rdx
               	movslq	%edx, %rcx
               	cmpq	$0x6, %rcx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rcx
               	movq	%rcx, %rdx
               	incq	%rdx
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x4, %rcx
               	movslq	%edx, %rsi
               	addq	%rsi, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rax, %rsi
               	movsbq	(%rsi), %rsi
               	cmpq	%rsi, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x12345678, %rax       # imm = 0x12345678
               	je	<addr>
               	jmp	<addr>
               	movq	%rdx, %rax
               	addq	$0x1e, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x28, %eax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %r13
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
