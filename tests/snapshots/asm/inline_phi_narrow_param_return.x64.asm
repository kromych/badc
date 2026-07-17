
inline_phi_narrow_param_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %ecx
               	xorq	%rax, %rax
               	jmp	<addr>
               	imulq	$0xf4243, %rcx, %rcx    # imm = 0xF4243
               	addq	%rax, %rcx
               	movslq	%ecx, %rsi
               	movslq	%esi, %rcx
               	incq	%rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x32, %rdx
               	jl	<addr>
               	cmpq	$-0x4728dfba, %rcx      # imm = 0xB8D72046
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
