
inline_phi_narrow_param_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<trunc_id>:
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	retq

<phi_accumulate>:
               	movslq	%edi, %rdi
               	movl	$0x1, %edx
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	imulq	$0xf4243, %rdx, %rax    # imm = 0xF4243
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rdx
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%ecx, %rax
               	cmpq	%rdi, %rax
               	jl	<addr>
               	movq	%rdx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x32, %edi
               	callq	<addr>
               	cmpq	$-0x4728dfba, %rax      # imm = 0xB8D72046
               	jne	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	jmp	<addr>
               	addb	%al, (%rax)
