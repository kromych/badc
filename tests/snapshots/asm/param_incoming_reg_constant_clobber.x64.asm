
param_incoming_reg_constant_clobber.x64:	file format elf64-x86-64

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

<func_1>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %esi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	(%rax), %edi
               	leaq	<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<func_10>:
               	movl	$0x5, %esi
               	movq	%rdx, %rdi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movzwq	(%rcx), %rcx
               	movsbq	%cl, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	cmpl	$0x1, %ecx
               	leaq	<rip>, %rcx      # <addr>
               	movslq	(%rcx), %rcx
               	orq	%rsi, %rcx
               	movq	%rcx, %rdx
               	shrq	$0x2, %rdx
               	shlq	$0x2, %rdx
               	subq	%rdx, %rcx
               	movq	(%rax), %rax
               	movzwq	(%rax), %rdx
               	movswq	%cx, %rax
               	movswq	%dx, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	jne	<addr>
               	cmpl	$-0x1, %ecx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rsi), %eax
               	cmpl	$0x5, %eax
               	jg	<addr>
               	movl	(%rdi), %eax
               	movl	%eax, (%rdi)
               	cmpl	$0x0, (%rcx)
               	jne	<addr>
               	movl	(%rsi), %eax
               	incq	%rax
               	movl	%eax, (%rsi)
               	movl	(%rsi), %eax
               	cmpl	$0x5, %eax
               	jle	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movzwq	(%rax), %rax
               	retq

<func_17>:
               	leaq	<rip>, %rax      # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %esi
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	(%rax), %edi
               	leaq	<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	movq	%rsi, %r8
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	cmpl	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
