
shift_result_type_signedness.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sext>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%r13, (%rsp)
               	movslq	%esi, %rsi
               	movl	%edi, %eax
               	movq	%rsi, %rcx
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	movq	%rsi, %rcx
               	sarq	%cl, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%r13, (%rsp)
               	movl	$0xfb, %eax
               	movl	$0x18, %ecx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0xff, %eax
               	movl	$0x18, %ecx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x80, %eax
               	movl	$0x18, %ecx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$-0x80, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7f, %eax
               	movl	$0x18, %ecx
               	movl	%eax, %eax
               	shlq	%cl, %rax
               	movl	%eax, %eax
               	movslq	%eax, %rax
               	sarq	%cl, %rax
               	cmpq	$0x7f, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	movl	$0x8000, %eax           # imm = 0x8000
               	shlq	$0x10, %rax
               	movslq	%eax, %rax
               	sarq	$0x10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
