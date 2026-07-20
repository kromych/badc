
unsigned_compound_assign.x64:	file format elf64-x86-64

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
               	movl	$0x587, %esi            # imm = 0x587
               	leaq	-0x40(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0xa, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x14, %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x1e, %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x40(%rbp), %rax
               	movl	$0x28, %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x40(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	cmpq	$0x1e, %rcx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	0xc(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
