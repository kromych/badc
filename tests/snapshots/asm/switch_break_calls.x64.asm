
switch_break_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<f1>:
               	movl	$0x64, %eax
               	retq

<f2>:
               	movl	$0xc8, %eax
               	retq

<f3>:
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq

<f4>:
               	movl	$0x190, %eax            # imm = 0x190
               	retq

<driver>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	cmpq	$0x1, %rbx
               	jl	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	callq	<addr>
               	movq	%rax, %rbx
               	jmp	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rbx
               	jl	<addr>
               	jmp	<addr>
               	cmpq	$0x1, %rbx
               	je	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %rbx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
