
inline_asm_clobber_probe.x64:	file format elf64-x86-64

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
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x40(%rbp)
               	movq	%rcx, -0x38(%rbp)
               	movq	%rdx, -0x30(%rbp)
               	movq	%rbx, -0x28(%rbp)
               	movq	%rsi, -0x20(%rbp)
               	movq	%rax, -0x18(%rbp)
               	movl	$0x1234, %esi           # imm = 0x1234
               	movl	$0x0, %eax
               	movl	$0x0, %ebx
               	movl	$0x0, %ecx
               	movl	$0x0, %edx
               	movq	-0x18(%rbp), %r10
               	movl	%esi, (%r10)
               	movq	-0x40(%rbp), %rax
               	movq	-0x38(%rbp), %rcx
               	movq	-0x30(%rbp), %rdx
               	movq	-0x28(%rbp), %rbx
               	movq	-0x20(%rbp), %rsi
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x1234, %rax           # imm = 0x1234
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
