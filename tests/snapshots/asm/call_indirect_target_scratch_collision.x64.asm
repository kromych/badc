
call_indirect_target_scratch_collision.x64:	file format elf64-x86-64

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

<sink_op>:
               	xorq	%rdx, %rdx
               	movsbq	(%rsi), %rax
               	addq	%rcx, %rax
               	movl	%eax, (%r8)
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x10(%rbp), %rdi
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rdi)
               	xorq	%rdx, %rdx
               	movl	%edx, -0x8(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x8(%rbp), %r8
               	movq	(%rdi), %rax
               	movl	$0xffff, %ecx           # imm = 0xFFFF
               	callq	*%rax
               	movslq	%eax, %rbx
               	leaq	<rip>, %rdi
               	movslq	-0x8(%rbp), %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%rbx, %rbx
               	jne	<addr>
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x10040, %eax          # imm = 0x10040
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
