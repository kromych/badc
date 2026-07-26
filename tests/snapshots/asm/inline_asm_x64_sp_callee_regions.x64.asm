
inline_asm_x64_sp_callee_regions.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, -0x60(%rbp)
               	movq	%rax, -0x58(%rbp)
               	movq	%rsp, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x38(%rbp), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	$0xa, %rax
               	leaq	-0x48(%rbp), %rcx
               	movq	%rax, -0x60(%rbp)
               	movq	%rcx, -0x58(%rbp)
               	movq	%rsp, %rax
               	movq	-0x58(%rbp), %r10
               	movq	%rax, (%r10)
               	movq	-0x60(%rbp), %rax
               	movq	-0x48(%rbp), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	addq	$0x14, %rcx
               	cmpq	$0xb, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x15, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	jmp	<addr>
