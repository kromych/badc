
call_indirect_target_scratch_collision.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink_op>:
               	xorq	%rax, %rax
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movl	%ecx, (%r8)
               	retq

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movslq	%ecx, %rcx
               	movq	(%rdi), %rax
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	callq	*%rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-<rip>, %rcx       # <addr>
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movl	%edx, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1ffff, %ecx          # imm = 0x1FFFF
               	leaq	-0x10(%rbp), %r8
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movslq	-0x10(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movslq	-0x10(%rbp), %rax
               	cmpq	$0x10040, %rax          # imm = 0x10040
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rcx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	jmp	<addr>
