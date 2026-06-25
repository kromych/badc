
inline_one_word_struct.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sr_obj>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<sum_sr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%esi, %rsi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rsi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movq	(%rdi,%rdx,8), %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	incq	%rcx
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movslq	%esi, %rsi
               	imulq	$0x64, %rsi, %rsi
               	movq	%rsi, (%rax,%rdx,8)
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x5, %esi
               	callq	<addr>
               	cmpq	$0x5dc, %rax            # imm = 0x5DC
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
