
ssa_callee_saved_x19.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x280, %esi            # imm = 0x280
               	callq	<addr>
               	ud2

<onExit>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-<rip>, %rdi       # <addr>
               	xorq	%rbx, %rbx
               	movq	%rbx, %rsi
               	movq	%rbx, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
