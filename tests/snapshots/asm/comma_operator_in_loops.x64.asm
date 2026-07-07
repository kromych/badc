
comma_operator_in_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<bump>:
               	movq	%rdi, %rcx
               	movslq	%ecx, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	addq	$0xa, %rbx
               	xorq	%r12, %r12
               	movq	%r12, %rdi
               	callq	<addr>
               	xorq	%rdi, %rdi
               	callq	<addr>
               	addq	$0x64, %rbx
               	movl	$0x7, %edi
               	callq	<addr>
               	addq	$0x3e8, %rbx            # imm = 0x3E8
               	xorq	%rdi, %rdi
               	callq	<addr>
               	incq	%rbx
               	xorq	%rdi, %rdi
               	callq	<addr>
               	incq	%rbx
               	xorq	%rdi, %rdi
               	callq	<addr>
               	incq	%rbx
               	xorq	%rdi, %rdi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x456(%rbx), %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	incq	%rbx
               	jmp	<addr>
               	addq	$0x1869f, %rbx          # imm = 0x1869F
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
