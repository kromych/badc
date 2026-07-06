
narrow_param_entry_extend.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<scale>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movsbq	%dil, %rdi
               	movswq	%si, %rsi
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	imulq	$0x186a0, %rdi, %rax    # imm = 0x186A0
               	imulq	$0xa, %rsi, %rcx
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<uscale>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%rcx, %rcx
               	movl	%ecx, -0x8(%rbp)
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	imulq	$0x186a0, %rax, %rax    # imm = 0x186A0
               	movl	%eax, %eax
               	movq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rbx
               	movq	%rbx, %rdi
               	movq	%rbx, %rdx
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x6bcd17, %rax         # imm = 0x6BCD17
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	cmpq	$0x696c65, %rax         # imm = 0x696C65
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
