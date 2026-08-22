
case_label_const_object.x64:	file format elf64-x86-64

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

<desig_and_static_init>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movl	$0x9, %esi
               	movl	%esi, 0x8(%rax)
               	movl	$0x5, %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rdi
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rdi
               	leaq	<rip>, %rdi
               	movl	%esi, (%rdi)
               	movl	$0x1, %esi
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	0x8(%rdx), %rax
               	cmpl	$0x7, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3e8, %eax            # imm = 0x3E8
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	(%rdi), %rax
               	cmpl	$0x9, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>

<stays_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x10, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	xorq	%rcx, %rcx
               	leaq	(%rax), %rdx
               	movl	%ecx, (%rdx)
               	movl	$0x1, %ecx
               	movl	%ecx, 0x4(%rax)
               	movl	$0x2, %ecx
               	movl	%ecx, 0x8(%rax)
               	movl	$0x3, %ecx
               	movl	%ecx, 0xc(%rax)
               	movslq	0xc(%rax), %rax
               	cmpl	$0x3, %eax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x6, %eax
               	movl	$0x4, %eax
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	xorq	%rcx, %rcx
               	movl	$0x1, %ecx
               	movl	$0x3, %eax
               	movl	$0x9, %eax
               	movl	$0x8, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
