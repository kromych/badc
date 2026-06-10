
param_incoming_reg_clobber.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<byte_copy>:
               	popq	%r10
               	subq	$0x30, %rsp
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdx, 0x30(%rbp)
               	jmp	<addr>
               	movl	0x30(%rbp), %eax
               	movq	%rax, %rcx
               	decq	%rcx
               	movl	%ecx, 0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rdi, %rax
               	incq	%rax
               	movq	%rsi, %rcx
               	incq	%rcx
               	movzbq	(%rsi), %rdx
               	movb	%dl, (%rdi)
               	movq	%rax, %rdi
               	movq	%rcx, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x30, %rsp
               	pushq	%r11
               	retq

<swap_or_copy>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdx, 0x20(%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	movslq	%ecx, %rcx
               	movq	%rdx, 0x30(%rbp)
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	movl	0x30(%rbp), %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movl	0x30(%rbp), %eax
               	decq	%rax
               	movl	%eax, %eax
               	movq	%rbx, %rcx
               	addq	%rax, %rcx
               	jmp	<addr>
               	movl	0x30(%rbp), %eax
               	movq	%rax, %rdx
               	decq	%rdx
               	movl	%edx, 0x30(%rbp)
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rcx, %rax
               	decq	%rax
               	movq	%rsi, %rdx
               	incq	%rdx
               	movzbq	(%rsi), %rsi
               	movb	%sil, (%rcx)
               	movq	%rax, %rcx
               	movq	%rdx, %rsi
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	incq	%rdx
               	movslq	%edx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x1, %ecx
               	callq	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	movl	$0x8, %edx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rdi
               	leaq	-0x8(%rbp), %rsi
               	movl	$0x8, %edx
               	xorq	%rbx, %rbx
               	movq	%rbx, %rcx
               	callq	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movslq	%ebx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	%ebx, %rcx
               	addq	%rcx, %rax
               	movzbq	(%rax), %rax
               	incq	%rcx
               	movslq	%ecx, %rcx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	addq	$0x14, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
