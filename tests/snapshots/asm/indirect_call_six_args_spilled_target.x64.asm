
indirect_call_six_args_spilled_target.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<do_cmp>:
               	movl	$0x1, %eax
               	movl	%eax, (%rsi)
               	movq	(%rdx), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	(%r8), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	retq

<run>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	movq	(%rdi), %rax
               	leaq	-0x8(%rbp), %r9
               	addq	$0x10, %rsi
               	addq	$0x10, %rcx
               	xchgq	%r9, %rsi
               	xchgq	%r8, %r9
               	xchgq	%rcx, %r8
               	xchgq	%rdx, %rcx
               	callq	*%rax
               	movslq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x8(%rbp), %rdi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x5, %edx
               	leaq	-0x48(%rbp), %rcx
               	movl	$0x9, %r8d
               	callq	<addr>
               	cmpq	$0xc0d, %rax            # imm = 0xC0D
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
