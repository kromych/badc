
branch_relaxation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<classify>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movl	$0x3, %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq
               	movslq	%eax, %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movl	$0x3, %esi
               	pushq	%rax
               	movq	%rdx, %rax
               	cqto
               	idivq	%rsi
               	popq	%rax
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	movslq	%eax, %rax
               	decq	%rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x2, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xa, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
