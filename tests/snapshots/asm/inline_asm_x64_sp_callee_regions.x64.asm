
inline_asm_x64_sp_callee_regions.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rsp, %rax
               	movq	-0x40(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x10(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	0xa(%rax), %rcx
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	%rsp, %rax
               	movq	-0x38(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x8(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	leaq	0x14(%rax), %rdx
               	cmpq	$0xb, %rcx
               	jne	<addr>
               	cmpq	$0x15, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
