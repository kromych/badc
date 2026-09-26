
indirect_call_six_args_spilled_target.x64:	file format elf64-x86-64

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

<do_cmp>:
               	movl	$0x1, (%rsi)
               	movq	(%rdx), %rax
               	imulq	$0x3e8, %rax, %rax      # imm = 0x3E8
               	movq	(%r8), %rdx
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r9, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	leaq	-0x50(%rbp), %rdi
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rdi)
               	leaq	-0x40(%rbp), %rax
               	movq	$0x3, 0x10(%rax)
               	leaq	-0x20(%rbp), %r8
               	movq	$0x7, 0x10(%r8)
               	movl	$0x5, %ecx
               	movl	$0x9, %r9d
               	movl	$0x0, -0x48(%rbp)
               	movq	(%rdi), %rdx
               	leaq	-0x48(%rbp), %rsi
               	addq	$0x10, %rax
               	addq	$0x10, %r8
               	subq	$0x10, %rsp
               	movq	%rdx, (%rsp)
               	movq	%rax, %rdx
               	movq	(%rsp), %r10
               	callq	*%r10
               	addq	$0x10, %rsp
               	movslq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc0d, %rax            # imm = 0xC0D
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
