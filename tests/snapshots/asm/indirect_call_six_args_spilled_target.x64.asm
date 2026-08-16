
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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x50(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x7, %ecx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	$0x5, %esi
               	movl	$0x9, %r9d
               	xorq	%rax, %rax
               	movl	%eax, -0x48(%rbp)
               	movq	(%rdi), %rax
               	leaq	-0x48(%rbp), %r8
               	addq	$0x10, %rcx
               	addq	$0x10, %rdx
               	xchgq	%r8, %rsi
               	xchgq	%rdx, %r8
               	xchgq	%rdx, %rcx
               	callq	*%rax
               	movslq	-0x48(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpq	$0xc0d, %rax            # imm = 0xC0D
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
